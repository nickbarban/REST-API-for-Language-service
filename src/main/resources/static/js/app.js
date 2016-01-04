var userManagerModule = angular.module('userManagerApp', [ 'ngAnimate' ]);

userManagerModule
		.controller(
				'userManagerController',
				function($scope, $http) {

					var urlBase = "";
					$scope.toggle = true;
					$scope.selection = [];
					$scope.states = [ 'Active', 'Inactive', 'Deleted', 'Locked' ];
					$scope.profiles = [ 'USER', 'ADMIN', 'DBA' ];

					function findAllLanguages() {
						$http
								.get(urlBase + '/languages')
								.success(
										function(data) {
											if (data._embedded != undefined) {
												$scope.languages = data._embedded.languages;
											} else {
												$scope.languages = [];
											}
											//$scope.toggle = '!toggle';

										});
					}

					$http.defaults.headers.post["Content-Type"] = "application/json";

					findAllLanguages();

					function findAllUsers() {
						$http
								.get(urlBase + '/users')
								.success(
										function(data) {
											if (data._embedded != undefined) {
												$scope.users = data._embedded.users;
											} else {
												$scope.users = [];
											}
											for (var i = 0; i < $scope.users.length; i++) {
												$scope.users[i].language = getUserLanguageById($scope.users[i].userId)
												if ($scope.users[i].state == 'Inactive') {
													$scope.selection
															.push($scope.users[i].userId);
												}
											}
											$scope.name = "";
											$scope.login = "";
											$scope.password = "";
											$scope.email = "";
											$scope.state = "";
											$scope.language = "";
											$scope.toggle = '!toggle';
										});
					}

					findAllUsers();

					// add a new user
					$scope.addUser = function addUser() {
						if ($scope.name == "" || $scope.login == ""
								|| $scope.password == "" || $scope.email == ""
								|| $scope.state == "" || $scope.language == "") {
							alert("Insufficient Data! Please provide values for user name, login, password, email, state and language");
						} else {
							$http.post(urlBase + '/users', {
								name : $scope.name,
								login : $scope.login,
								password : $scope.password,
								email : $scope.email,
								state : $scope.state,
								language : $scope.language
							}).success(
									function(data, status, headers) {
										alert("User added");
										var newUserUri = headers()["location"];
										console.log("Might be good to GET "
												+ newUserUri
												+ " and append the user.");
										// Refetching EVERYTHING every time can
										// get expensive over time
										// Better solution would be to
										// $http.get(headers()["location"]) and
										// add it to the list
										findAllUsers();
										$scope.toggle = '!toggle';
									});
						}

					};

					$scope.toggleSelection = function toggleSelection(userUri) {
						var idx = $scope.selection.indexOf(userUri);

						if (idx > -1) {
							$http.patch(userUri, {
								state : 'Active'
							}).success(function(data) {
								alert("User unmarked");
								findAllUsers();
							});
							$scope.selection.splice(idx, 1);
						}

						else {
							$http.patch(userUri, {
								state : 'Inactive'
							}).success(function(data) {
								alert("User marked inactive");
								findAllUsers();
							});
							$scope.selection.push(userUri);
						}
					};

					// Delete Users with state Deleted
					$scope.deleteUsers = function archiveUsers() {
						$scope.selection.forEach(function(userUri) {
							if (userUri != undefined) {
								$http.patch(userUri, {
									state : "Deleted"
								});
							}
						});
						alert("Successfully Deleted");
						console
								.log("It's risky to run this without confirming all the patches are done. when.js is great for that");
						findAllUsers();
					};

				});

// Angularjs Directive for confirm dialog box
userManagerModule.directive('ngConfirmClick', [ function() {
	return {
		link : function(scope, element, attr) {
			var msg = attr.ngConfirmClick || "Are you sure?";
			var clickAction = attr.confirmedClick;
			element.bind('click', function(event) {
				if (window.confirm(msg)) {
					scope.$eval(clickAction);
				}
			});
		}
	};
} ]);
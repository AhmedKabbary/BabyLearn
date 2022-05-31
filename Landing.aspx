<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Landing.aspx.cs" Inherits="BabyLearn.Landing" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="assets/bootstrap-5.1.3-dist/css/bootstrap.css" />
    <link rel="stylesheet" href="assets/bootstrap-icons-1.8.1/bootstrap-icons.css" />

    <title>BLearn - Develop your child's skills</title>
</head>
<body>
    <form id="form1" runat="server">
        <header class="bg-light" style="height: 100vh;">

            <nav class="navbar navbar-expand-sm sticky-top navbar-light bg-light">
                <div class="container">
                    <a class="navbar-brand" href="#">
                        <span class="fw-bolder text-primary">Baby</span>
                        <span class="fw-bolder">Learn</span>
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="#features">Features</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#about">About</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#contact-us">Contact us</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>

            <div class="container" style="height: calc(100% - 56px);">
                <div class="row justify-content-between" style="height: 100%;">

                    <div class="col-sm-12 col-lg-5 align-self-center">

                        <h1 class="display-4 fw-bold mb-3">Develop your child skills</h1>
                        <p class="text-secondary mb-5">
                            By learning the alphabet, colors, drawing, living organisms like animals and plants
                        and developing his skills through interactive games using artificial intelligence.
                   
                        </p>
                        <a href="Register.aspx" class="btn btn-primary rounded-pill ps-4 pe-4 pt-2 pb-2">
                            <span>Get started</span>
                            &ensp;
                            <img style="width: 16px; margin-bottom: 2.5px;" src="assets/icons/arrow_forward.svg" />
                        </a>

                    </div>

                    <div class="col-sm-12 col-lg-5 align-self-center d-none d-md-block">
                        <img class="w-100" src="assets/icons/fatherhood.svg" />
                    </div>

                </div>
            </div>

        </header>

        <section id="features" class="text-center pt-5 pb-5">
            <div class="container">
                <h2 class="fw-bold mb-5">Features</h2>
                <div class="row">
                    <div class="col-12 col-md-4">
                        <div class="d-flex justify-content-center">
                            <div style="background-color: #0d6efd; border-radius: 50%; padding: 24px;">
                                <img src="assets/icons/learn.svg" width="75" />
                            </div>
                        </div>
                        <h3 class="mt-3 mb-3">Learn</h3>
                        <p class="text-secondary">
                            We teach your child the basics of life such as colors, animals, fruits,
                        vegetables and human organs
                   
                        </p>
                    </div>
                    <div class="col-12 col-md-4">
                        <div class="d-flex justify-content-center">
                            <div style="background-color: #0d6efd; border-radius: 50%; padding: 24px;">
                                <img src="assets/icons/test.svg" width="75" />
                            </div>
                        </div>
                        <h3 class="mt-3 mb-3">Test</h3>
                        <p class="text-secondary">
                            We test your child and monitor his progress so we can strength him in his
                        weaknesses
                        </p>
                    </div>
                    <div class="col-12 col-md-4">
                        <div class="d-flex justify-content-center">
                            <div style="background-color: #0d6efd; border-radius: 50%; padding: 24px;">
                                <img src="assets/icons/draw.svg" width="75" />
                            </div>
                        </div>
                        <h3 class="mt-3 mb-3">Draw</h3>
                        <p class="text-secondary">
                            We improve the child's drawing abilities by displaying a simple image and
                        asking him to draw it
                        </p>
                    </div>
                </div>
            </div>
        </section>

        <section id="about" class="bg-light text-center pt-5 pb-5">
            <h2 class="fw-bold mb-5">About</h2>

            <div id="team-div" class="d-flex flex-row flex-nowrap overflow-auto">
                <div class="mx-auto"></div>
                <div class="mx-4">
                    <div class="d-flex justify-content-center">
                        <img src="assets/icons/woman.jpg"
                            width="150" height="150" class="rounded-pill" />
                    </div>
                    <h6 class="mt-3 mb-1">Nermeen Ibrahim</h6>
                    <p class="text-secondary">Database Admin</p>
                </div>
                <div class="mx-4">
                    <div class="d-flex justify-content-center">
                        <img src="assets/icons/woman.jpg"
                            width="150" height="150" class="rounded-pill" />
                    </div>
                    <h6 class="mt-3 mb-1">Yomna Amer</h6>
                    <p class="text-secondary">Database Admin</p>
                </div>
                <div class="mx-4">
                    <div class="d-flex justify-content-center">
                        <img src="assets/icons/man.jpg"
                            width="150" height="150" class="rounded-pill" />
                    </div>
                    <h6 class="mt-3 mb-1">Mohamed Gamal</h6>
                    <p class="text-secondary">Backend Developer</p>
                </div>
                <div class="mx-4">
                    <div class="d-flex justify-content-center">
                        <img src="assets/icons/man.jpg"
                            width="150" height="150" class="rounded-pill" />
                    </div>
                    <h6 class="mt-3 mb-1">Ahmed Qabbary</h6>
                    <p class="text-secondary">Team leader</p>
                </div>
                <div class="mx-4">
                    <div class="d-flex justify-content-center">
                        <img src="assets/icons/woman.jpg"
                            width="150" height="150" class="rounded-pill" />
                    </div>
                    <h6 class="mt-3 mb-1">Neda Abdelkhalik</h6>
                    <p class="text-secondary">Backend Developer</p>
                </div>
                <div class="mx-4">
                    <div class="d-flex justify-content-center">
                        <img src="assets/icons/woman.jpg"
                            width="150" height="150" class="rounded-pill" />
                    </div>
                    <h6 class="mt-3 mb-1">Shahd Baher</h6>
                    <p class="text-secondary">Frontend Developer</p>
                </div>
                <div class="mx-4">
                    <div class="d-flex justify-content-center">
                        <img src="assets/icons/man.jpg"
                            width="150" height="150" class="rounded-pill" />
                    </div>
                    <h6 class="mt-3 mb-1">Bassam Kamal</h6>
                    <p class="text-secondary">Frontend Developer</p>
                </div>
                <div class="mx-auto"></div>
            </div>
        </section>

        <section id="contact-us" class="text-center pt-5 pb-5">
            <div class="container">
                <h2 class="fw-bold mb-5">Contact us</h2>
                <div class="row">
                    <div class="col d-none d-md-block">
                        <img src="assets/icons/contact_us.svg" width="320" />
                    </div>
                    <div class="col text-start">
                        <div>
                            <input type="text" class="form-control mb-3" id="nameInput" placeholder="Name" />
                            <input type="email" class="form-control mb-3" id="emailInput" placeholder="Email" />
                            <textarea class="form-control mb-3" id="messageInput" placeholder="Message" rows="5"></textarea>
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <footer class="text-center text-white" style="background-color: #f1f1f1;">
            <div class="container pt-2 pb-2">
                <!-- Facebook -->
                <a class="btn btn-link btn-floating btn-lg text-dark m-1" href="#!" role="button"
                    data-mdb-ripple-color="dark"><i class="bi bi-facebook"></i></a>

                <!-- Twitter -->
                <a class="btn btn-link btn-floating btn-lg text-dark m-1" href="#!" role="button"
                    data-mdb-ripple-color="dark"><i class="bi bi-twitter"></i></a>

                <!-- Google -->
                <a class="btn btn-link btn-floating btn-lg text-dark m-1" href="#!" role="button"
                    data-mdb-ripple-color="dark"><i class="bi bi-google"></i></a>

                <!-- Instagram -->
                <a class="btn btn-link btn-floating btn-lg text-dark m-1" href="#!" role="button"
                    data-mdb-ripple-color="dark"><i class="bi bi-instagram"></i></a>

                <!-- Linkedin -->
                <a class="btn btn-link btn-floating btn-lg text-dark m-1" href="#!" role="button"
                    data-mdb-ripple-color="dark"><i class="bi bi-linkedin"></i></a>
                <!-- Github -->
                <a class="btn btn-link btn-floating btn-lg text-dark m-1" href="#!" role="button"
                    data-mdb-ripple-color="dark"><i class="bi bi-github"></i></a>
            </div>

            <div class="text-center text-dark p-3" style="background-color: rgba(0, 0, 0, 0.2);">
                © 2022 Hunters - All Rights Reserved
       
            </div>
        </footer>

        <script src="assets/bootstrap-5.1.3-dist/js/bootstrap.bundle.js"></script>

        <script>
            var teamDiv = document.querySelector('#team-div');

            function calc_scroll_pos() {
                teamDiv.scrollLeft = (teamDiv.scrollWidth - teamDiv.clientWidth) / 2;
            }

            document.body.onresize = calc_scroll_pos();
            calc_scroll_pos();
        </script>
    </form>
</body>
</html>

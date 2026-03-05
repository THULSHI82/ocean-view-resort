<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ocean View Resort | Staff Login</title>

    <style>
        :root{
            --primary:#111827;
            --primaryHover:#000;
            --muted:#6b7280;
            --border:#e5e7eb;
        }

        *{box-sizing:border-box;}

        body{
            margin:0;
            font-family: system-ui, -apple-system, Segoe UI, Roboto;
            min-height:100vh;
            display:flex;
            align-items:center;
            justify-content:center;
            background:
                    linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)),
                    url("https://images.unsplash.com/photo-1501117716987-c8e2a74c3d0d?q=80&w=2070&auto=format&fit=crop") center/cover no-repeat;
        }

        .shell{
            width:1150px;
            max-width:95%;
            display:grid;
            grid-template-columns:1.2fr 0.8fr;
            background:#fff;
            border-radius:20px;
            overflow:hidden;
            box-shadow:0 30px 70px rgba(0,0,0,0.3);
        }

        /* LEFT PANEL */
        .brand{
            background:#0f172a;
            color:#fff;
            padding:60px;
            display:flex;
            flex-direction:column;
            justify-content:center;
        }

        .brand h1{
            font-size:34px;
            margin-bottom:15px;
        }

        .brand p{
            font-size:14px;
            line-height:1.7;
            color:#d1d5db;
            margin-bottom:25px;
        }

        .socials{
            display:flex;
            gap:18px;
        }

        .socials svg{
            width:22px;
            height:22px;
            fill:#fff;
            opacity:0.8;
            cursor:pointer;
            transition:0.3s ease;
        }

        .socials svg:hover{
            opacity:1;
        }

        /* RIGHT PANEL */
        .formPanel{
            padding:60px;
        }

        .formPanel h2{
            margin-bottom:8px;
        }

        .formPanel p{
            margin-bottom:25px;
            font-size:13px;
            color:var(--muted);
        }

        .field{
            margin-bottom:20px;
        }

        label{
            display:block;
            font-size:12px;
            margin-bottom:6px;
            color:var(--muted);
        }

        .control{
            position:relative;
        }

        input{
            width:100%;
            padding:12px 42px 12px 12px;
            border-radius:10px;
            border:1px solid var(--border);
            font-size:14px;
        }

        input:focus{
            border-color:#000;
            outline:none;
        }

        .eye{
            position:absolute;
            right:12px;
            top:50%;
            transform:translateY(-50%);
            cursor:pointer;
            width:18px;
            height:18px;
            fill:#6b7280;
        }

        button{
            width:100%;
            padding:12px;
            background:var(--primary);
            color:#fff;
            border:none;
            border-radius:10px;
            font-weight:600;
            cursor:pointer;
            transition:0.2s ease;
        }

        button:hover{
            background:var(--primaryHover);
        }

        .alert{
            padding:10px;
            border-radius:8px;
            margin-bottom:15px;
            font-size:13px;
        }

        .error{
            background:#fee2e2;
            color:#991b1b;
        }

        .success{
            background:#d1fae5;
            color:#065f46;
        }

        input::placeholder {
            color: #9ca3af;
            font-size: 13px;
        }

        .footer{
            margin-top:20px;
            font-size:12px;
            color:var(--muted);
        }
    </style>
</head>

<body>

<div class="shell">

    <div class="brand">
        <h1>Ocean View Resort</h1>
        <p>
            Located along the pristine coastline, Ocean View Resort offers world-class
            hospitality, luxurious suites, fine dining experiences, and breathtaking
            sunsets overlooking the sea. Our commitment to excellence ensures every
            guest enjoys comfort, elegance, and unforgettable moments.
        </p>

        <div class="socials">
            <!-- Facebook -->
            <svg viewBox="0 0 24 24"><path d="M22 12a10 10 0 10-11.6 9.9v-7H7v-3h3.4V9.4c0-3.4 2-5.4 5.1-5.4 1.5 0 3 .3 3 .3v3.3h-1.7c-1.7 0-2.3 1.1-2.3 2.2V12H18l-.6 3h-2.8v7A10 10 0 0022 12z"></path></svg>
            <!-- Instagram -->
            <svg viewBox="0 0 24 24"><path d="M7 2C4 2 2 4 2 7v10c0 3 2 5 5 5h10c3 0 5-2 5-5V7c0-3-2-5-5-5H7zm5 6a4 4 0 110 8 4 4 0 010-8zm6.5-1.3a1.3 1.3 0 110 2.6 1.3 1.3 0 010-2.6z"></path></svg>
            <!-- Twitter -->
            <svg viewBox="0 0 24 24"><path d="M22 5.9c-.8.4-1.6.6-2.4.7.9-.5 1.5-1.3 1.8-2.3-.8.5-1.7.9-2.6 1.1A4.1 4.1 0 0012 8.1a11.6 11.6 0 01-8.4-4.3 4.1 4.1 0 001.3 5.4c-.7 0-1.3-.2-1.9-.5v.1c0 2 1.5 3.7 3.4 4.1-.4.1-.8.2-1.2.2-.3 0-.6 0-.8-.1.6 1.7 2.2 3 4.1 3A8.3 8.3 0 012 19.5 11.7 11.7 0 008.3 21c7.5 0 11.6-6.3 11.6-11.6v-.5c.8-.6 1.5-1.3 2.1-2z"></path></svg>
        </div>
    </div>

    <div class="formPanel">
        <h2>Staff Login</h2>
        <p>Enter your secure credentials to access the reservation dashboard.</p>

        <% if (request.getAttribute("error") != null) { %>
        <div class="alert error"><%= request.getAttribute("error") %></div>
        <% } %>

        <% if (request.getAttribute("success") != null) { %>
        <div class="alert success"><%= request.getAttribute("success") %></div>

        <script>
            setTimeout(function() {
                window.location.href = "<%= request.getContextPath() %>/dashboard?page=home";
            }, 1500);
        </script>
        <% } %>

        <form method="post" action="${pageContext.request.contextPath}/login">

            <div class="field">
                <label>Username</label>
                <div class="control">
                    <label>
                        <input type="text" name="username" placeholder="Username" autocomplete="username" required>
                    </label>
                </div>
            </div>

            <div class="field">
                <label>Password</label>
                <div class="control">
                    <label for="password"></label><input type="password" id="password" name="password" placeholder="Enter password" autocomplete="current-password" required>
                    <svg class="eye" onclick="togglePassword()" viewBox="0 0 24 24">
                        <path d="M12 5c-7 0-10 7-10 7s3 7 10 7 10-7 10-7-3-7-10-7zm0 11a4 4 0 110-8 4 4 0 010 8z"></path>
                    </svg>
                </div>
            </div>

            <button type="submit">Sign In</button>

            <div class="footer">
                © 2026 Ocean View Resort
            </div>

        </form>
    </div>

</div>

<script>
    function togglePassword(){
        const pwd = document.getElementById("password");
        pwd.type = pwd.type === "password" ? "text" : "password";
    }
</script>

</body>
</html>
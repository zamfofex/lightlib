import fs from "fs"
import process from "process"

let fsp = fs.promises

let main = async () =>
{
	for (let name of await fsp.readdir("html"))
	{
		if (!name.startsWith("Light.") && name !== "index.html") continue
		if (!name.endsWith(".html")) continue
		
		fsp.writeFile(
			"public/" + name,
			(await fsp.readFile("html/" + name, "utf-8"))
				.replace("</head>", `<meta name="viewport" content="width=device-width,initial-scale=1"></head>`)
				.replace("<body>", `<body><a href="." id="header"><header>lightlib</header></a>`)
				.replace("</title>", ` &mdash; lightlib</title>`)
		).catch(err => process.exit(1))
	}
}

main().catch(err => process.exitCode = 1)

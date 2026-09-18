# ac26-zeitplan

Zeitleiste (Gantt-Ansicht) für die Planung der AC-Zeltlager. Liest die Aufgaben
live aus Microsoft Planner und stellt sie als Balkenplan dar – lesend, gepflegt
wird weiterhin in Planner selbst.

**Live:** https://falwin.github.io/ac26-zeitplan/

## Eine Seite je AC-Jahr

Der Parameter `?board=AC<Jahr>` legt die Seite auf ein Board fest. So bekommt
jedes Jahr seinen eigenen Teams-Tab, ohne dass es den Code zweimal gibt:

| Adresse | zeigt |
|---|---|
| `…/ac26-zeitplan/` | gespeicherte Wahl, sonst das AC26-Board |
| `…/ac26-zeitplan/?board=AC26` | festgelegt auf AC26 |
| `…/ac26-zeitplan/?board=AC27` | festgelegt auf AC27 |

Erkannt wird ein Board über seinen Titel (`AC<Jahr> …`) im Team **AC Planung**.
Ein künftiges AC28-Board funktioniert damit ohne Codeänderung – es braucht nur
einen neuen Link.

**Wichtig:** Der Link muss auf das Verzeichnis mit Schrägstrich am Ende zeigen.
`…/index.html?board=AC27` scheitert an der Anmeldung, weil die in Azure
hinterlegte Rückadresse dann nicht mehr passt.

Bei festgelegtem Board ist der Board-Umschalter ausgeblendet: Der Auto-Sync löst
das Board bei jedem Durchlauf neu auf und würde eine abweichende Wahl nach
wenigen Minuten still zurücksetzen. Das Jahr wechselt man über den Tab.

## Aufbau

Eine einzelne HTML-Datei (`index.html`) ohne Bau-Schritt und ohne Abhängigkeiten
im Repo. Anmeldung über MSAL.js 3.7.1, Daten über die Microsoft Graph API.

- **Weiterleitungs-Anmeldung, kein Popup** – in Teams funktioniert Popup nicht.
- Ablage in `localStorage`, nicht `sessionStorage`.
- `navigateToLoginRequestUrl: false`.

## Ändern und veröffentlichen

```bash
./pruefen.sh            # Syntaxprüfung, Ergebnis am Exit-Code (0 = grün)
git commit -am "vX.Y.Z – …"
git push origin main
```

GitHub Pages baut aus `main` im Wurzelverzeichnis. Nach dem Push prüfen, ob die
neue Version wirklich ausgeliefert wird – der Build-Status allein genügt nicht:

```bash
curl -s https://falwin.github.io/ac26-zeitplan/ | grep -oE "Microsoft Planner · v[0-9.]+"
```

Die Versionsnummer steht in `index.html` in der Zeile mit `class="subtitle"`.
`v2.0.x` = Patch, `v2.x.0` = Feature. Änderungen gehören ins [CHANGELOG](CHANGELOG.md).

## Grenzen

- Lokal lässt sich die App **nicht anmelden**: `http://localhost:…` ist in der
  Azure-App-Registrierung nicht als Rückadresse eingetragen. Prüfbar sind lokal
  nur die Abläufe, die ohne Graph auskommen.
- `getToken()` behandelt jeden Fehler als „Anmeldung nötig" und leitet ganzseitig
  weiter – auch bei einem kurzen Netzaussetzer. Noch offen.

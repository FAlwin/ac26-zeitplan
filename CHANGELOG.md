# Changelog

Alle nennenswerten Änderungen an der Zeitleiste (`index.html`).
Format nach [Keep a Changelog](https://keepachangelog.com/de/1.1.0/),
Versionierung: `v2.0.x` = Patch, `v2.x.0` = Feature.

> Hinweis: Dieses Changelog wurde am 18.09.2026 nachträglich angelegt und aus den
> Commits rekonstruiert. Die Einträge ab v2.0.17 sind am Code gegengeprüft.
> Für ältere Versionen (v1.x bis v2.0.16) gibt es nur Commit-Nachrichten ohne
> Inhalt – sie wurden bewusst **nicht** erfunden.

## [2.2.1] – 2026-09-18

### Geändert
- „Plan übernehmen" liegt jetzt in einer Funktion `applyPlan()`. Vorher standen
  dieselben fünf Anweisungen (Kennung, Speichereintrag, Kopftitel, Browser-Titel,
  Knopf-Beschriftung) zeichengleich in `findPlanId()` **und** `selectPlan()`.

### Entfernt
- `planner-zeitplan-v1_15.html` und `planner-zeitplan-v2_0_11.html` aus dem Repo.
  Beide wurden über GitHub Pages öffentlich ausgeliefert und benutzten noch den
  in v2.0.17 verworfenen Popup-Login, waren aus Teams also unbenutzbar.
  Abrufbar bleiben sie in der Git-Historie.
- Auskommentierter Testdaten-Block `TASKS_DEMO` (28 Zeilen). Er war die letzte
  Stelle im Code mit fest eingetragenen AC26-Terminen.

## [2.2.0] – 2026-09-09

### Neu
- Eigene URL je AC-Jahr über den Parameter `?board=AC27`, damit AC26 und AC27
  parallel als getrennte Teams-Tabs laufen können, ohne den Code zu verdoppeln.
  Ohne Parameter verhält sich die Seite unverändert wie bisher.
- Die Plan-Kennung wird getrennt je Board abgelegt
  (`ac_zeitplan_plan_id:AC27`), sonst schlägt ein Umschalten im einen Tab in den
  anderen durch. Ohne Parameter bleibt der alte globale Schlüssel gültig.

### Behoben
- Der Parameter überlebt jetzt die Microsoft-Weiterleitung. `redirectUri` ist
  `origin + pathname`, der Teil hinter dem `?` fällt beim Redirect weg; er wird
  deshalb vorher geparkt und danach samt Adresszeile wiederhergestellt.
  Betroffen sind **drei** Stellen: `loginRedirect`, `acquireTokenRedirect` und
  `logoutRedirect`.
- Die Einschränkung „nur Boards aus dem Team *AC Planung*" stand bisher nur im
  dritten Rückfall, nicht im zweiten. Da `/me/memberOf` keine Reihenfolge
  garantiert, konnte ein gleichnamiges Board aus einer anderen Gruppe gewinnen.
- Eine gespeicherte Plan-Kennung, deren Plan nicht mehr existiert, führt nicht
  mehr in den Fehler „Kein passender Plan gefunden", sondern wird übersprungen.
- Ein auf ein Jahr festgelegter Tab zeigt nie still ein anderes Jahr: Passt die
  gespeicherte Wahl nicht, wird sie verworfen; fehlt das Board ganz, erscheint
  eine klare Meldung statt eines Rückfalls auf AC26.

### Geändert
- Bei festgelegtem Board ist der Board-Umschalter ausgeblendet. Der Auto-Sync
  löst das Board bei jedem Durchlauf neu auf und hätte eine abweichende Wahl
  nach wenigen Minuten still zurückgesetzt.

## [2.1.0] – 2026-05-19

### Neu
- Board-Umschalter: Ein Fenster listet die Pläne aus dem Team *AC Planung*, die
  Auswahl wird gespeichert und überlebt das Neuladen.

## [2.0.19] – 2026-05-19

### Behoben
- Plan-Erkennung gehärtet: erst exakter Titel, dann gespeicherte Kennung, erst
  zuletzt „enthält Planboard". Vorher wurde teils das Leitungsboard erwischt.

## [2.0.18] – 2026-05-19

### Geändert
- Es wird immer neu gezeichnet; der Sprung auf „heute" passiert nur beim ersten
  Laden. Übersprungene Aufgaben werden nach Grund gezählt und protokolliert.

## [2.0.17] – 2026-05-19

### Behoben
- Anmeldung von Popup auf Weiterleitung umgestellt (`loginRedirect`,
  `acquireTokenRedirect`), Ablage von `sessionStorage` auf `localStorage`,
  `navigateToLoginRequestUrl: false`. Ohne das funktioniert die Anmeldung
  innerhalb von Teams nicht.

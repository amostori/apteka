1. Tworzenie ikony okrągłej
   Na stronie https://makeappicon.com/result/ można wykreować ikony normalne i okrągłe.
2. Dependencies

dart run build_runner build
dart run build_runner build -d
flutter packages pub run flutter_launcher_icons:main
flutter build web

void addTodo(Todo todo) {
// Since our state is immutable, we are not allowed to do `state.add(todo)`.
// Instead, we should create a new list of todos which contains the previous
// items and the new one.
// Using Dart's spread operator here is helpful!
state = [...state, todo];
// No need to call "notifyListeners" or anything similar. Calling "state ="
// will automatically rebuild the UI when necessary.
}

void removeTodo(String todoId) {
// Again, our state is immutable. So we're making a new list instead of
// changing the existing list.
state = [
for (final todo in state)
if (todo.id != todoId) todo,
];
}
void toggle(String todoId) {
state = [
for (final todo in state)
// we're marking only the matching todo as completed
if (todo.id == todoId)
// Once more, since our state is immutable, we need to make a copy
// of the todo. We're using our `copyWith` method implemented before
// to help with that.
todo.copyWith(completed: !todo.completed)
else
// other todos are not modified
todo,
];
}

----------------------------------------------------------------
Git:

1. `git init`
2. Stwórz plik `.gitignore`
3. `git add .`
4. Aby usunąć plik po git add: `git rm --cache nazwa.pliku`
5. `git commit -m "message"`. Inna wersja `git commit -am "message"` - dodawanie do stage i
   commitowawnie
6. `git checkout -- nazwa.pliku`, usuwa zmiany jak po ctrl+z - Aby to zobaczyć trzeba otworzyć plik
   ponownie.
7. Podobnie działa komenda `git restore nazwa.pliku`
8. Jeśli plik został dodany do stage (`git add`) należy użyć komendy `git reset HEAD nazwa.pliku`,
   aby wyjąć go ze
   stage'a
   i następnie
   komendą `git checkout -- nazwa.pliku` można cofnąć ostatnie zmiany.

Po commit: `git tag -a M2 -m "whatsoever"` by nadać tag bieżącemu commitowi.
Następnie:
`git checkout TAG` by przenieść się do commita. Po pracy przed powrotem do ostatniego
commita usuń wszystkie zmiany z bieżącego: `git reset --hard`.
Aby stagować stare commity:
`git tag -a TAG numer_hasha_commita -m "Tag Message"`
Aby wysłać tagi na Githuba:
`git push --tags`

`git reflog` by zobaczyć wszystkie logi i hashe
`git checkout main` by wrócić do ostatniego commita
`⌥ + ⇧` multi cursor
`pip freeze > requirements.txt`
---
// flutter build apk --split-per-abi
// open ios/Runner.xcworkspace
// Theme.of(context).accentColor
// flutter build appbundle
// flutter build ipa
// open ios/Runner.xcworkspace
// Pełny ekran dla pola edycji: ctrl+shift+F12
// F2 lub SHIFT+F2 służy do przeskakiwania od błędu do błędu.
// Zamknięcie aktualnie otworzonego pliku: ctrl+F4
// Uruchom terminal: ALT+F12
// µ Ś  Ł
// ctrl + shift + alt + j - zaznacz wszystkie podobne
// ctrl + alt + o - optymalizacja importów
// ctrl + shift + f - szukaj wszędzie
// _total.toStringAsFixed(1)
// multi cursor: press and hold 'option'
// W przypadku błędu przy validate app może pomóc aktualizacja flutter,
// rozwiązanie żółtego ostrzeżenia w  xcode

dart run flutter_native_splash:create
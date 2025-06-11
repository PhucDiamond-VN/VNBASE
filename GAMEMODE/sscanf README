# sscanf 2.13.8

## Introduction

This is the `sscanf` plugin, which provides the `sscanf` function to extract basic structured data from strings.  This is slightly different to regular expressions, but both have their place.  A regular expression gives you total control over the exact structure of data down to the character level; however, extracting structured data like numbers using it is tricky.  Conversely this gives slightly higher-level "specifiers" which can easily extract data types, at the expense of fine-grained control.  To convert a string in to two numbers would look like:

```pawn
new num1, num2;
sscanf("45 100", "ii", num1, num2);
```

`ii` is the specifier string, which here means "integer integer"; stating that the input string should be two whole numbers in a row (which is - `"45 100"`).  `num1` and `num2` are the destination variables to store the found numbers in (after conversion from strings).  You can check if the conversion failed by looking for a non-naught return value:

```pawn
new num1, num2;
if (sscanf("hello 100", "ii", num1, num2))
{
	printf("The input was not two numbers.");
}
```

This will fail because `"hello"` is not a whole number (or indeed any type of number at all).  For more information on using the function refer to the tutorials or the reference documentation below:

## Contents

* 1 [Introduction](#introduction)
* 2 [Contents](#contents)
* 3 [Downloads](#downloads)
* 4 [Use](#use)
	* 4.1 [Scripting](#scripting)
	* 4.2 [open.mp](#openmp)
	* 4.3 [SA:MP Windows](#samp-windows)
	* 4.4 [SA:MP Linux](#samp-linux)
	* 4.5 [NPC Modes](#npc-modes)
* 5 [Tutorials](#tutorials)
    * 5.1 [`/sendcash` Command](#sendcash-command)
    * 5.2 [INI Parser](#ini-parser)
* 6 [Specifiers](#specifiers)
    * 6.1 [Strings](#strings)
    * 6.2 [Packed Strings](#packed-strings)
    * 6.3 [Arrays](#arrays)
    * 6.4 [Enums](#enums)
    * 6.5 [Provided Lengths](#provided-lengths)
    * 6.6 [Quiet](#quiet)
    * 6.7 [Searches](#searches)
    * 6.8 [Enums](#enums)
    * 6.9 [Delimiters](#delimiters)
    * 6.10 [Optional specifiers](#optional-specifiers)
    * 6.11 [Users](#users)
    * 6.12 [Custom (kustom) specifiers](#custom-kustom-specifiers)
    * 6.13 [Colours](#colours)
        * 6.13.1 [3 digits](#3-digits)
        * 6.13.2 [6 digits](#6-digits)
        * 6.13.3 [8 digits](#8-digits)
* 7 [Options](#options)
    * 7.1 [OLD_DEFAULT_NAME:](#old_default_name)
    * 7.2 [MATCH_NAME_PARTIAL:](#match_name_partial)
    * 7.3 [CELLMIN_ON_MATCHES:](#cellmin_on_matches)
    * 7.4 [SSCANF_QUIET:](#sscanf_quiet)
    * 7.5 [OLD_DEFAULT_KUSTOM:](#old_default_kustom)
    * 7.6 [SSCANF_ALPHA:](#sscanf_alpha)
    * 7.7 [SSCANF_COLOUR_FORMS:](#sscanf_colour_forms)
    * 7.8 [SSCANF_ARGB:](#sscanf_argb)
    * 7.9 [MATCH_NAME_FIRST:](#match_name_first)
    * 7.10 [MATCH_NAME_SIMILARITY:](#match_name_similarity)
* 8 [All Specifiers](#all-specifiers)
* 9 [Full API](#full-api)
    * 9.1 [`sscanf(const data[], const format[], {Float, _}:...);`](#sscanfconst-data-const-format-float-_)
    * 9.2 [`unformat(const data[], const format[], {Float, _}:...);`](#unformatconst-data-const-format-float-_)
    * 9.3 [`SSCANF_Option(const name[], value);`](#sscanf_optionconst-name-value)
    * 9.4 [`SSCANF_Option(const name[]);`](#sscanf_optionconst-name)
    * 9.5 [`SSCANF_SetOption(const name[], value);`](#sscanf_setoptionconst-name-value)
    * 9.6 [`SSCANF_GetOption(const name[], value);`](#sscanf_getoptionconst-name-value)
    * 9.7 [`SSCANF_Version(version[], size = sizeof (version));`](#sscanf_versionversion-size--sizeof-version)
    * 9.8 [`SSCANF_Version();`](#sscanf_version)
    * 9.9 [`SSCANF_VersionString(version[], size = sizeof (version));`](#sscanf_versionstringversion-size--sizeof-version)
    * 9.10 [`SSCANF_VersionBCD();`](#sscanf_versionbcd)
    * 9.11 [`SSCANF_Levenshtein(const string1[], const string2[]);`](#sscanf_levenshteinconst-string1-const-string2)
    * 9.12 [`Float:SSCANF_TextSimilarity(const string1[], const string2[]);`](#floatsscanf_textsimilarityconst-string1-const-string2)
    * 9.13 [`SSCANF_GetClosestString(const input[], const candidates[][], threshold = cellmax, count = sizeof (candidates));`](#sscanf_getcloseststringconst-input-const-candidates-threshold--cellmax-count--sizeof-candidates)
    * 9.14 [`SSCANF_GetClosestValue(const input[], const candidates[][], const results[], fail = cellmin, threshold = cellmax, count = sizeof (candidates), check = sizeof (results));`](#sscanf_getclosestvalueconst-input-const-candidates-const-results-fail--cellmin-threshold--cellmax-count--sizeof-candidates-check--sizeof-results)
    * 9.15 [`SSCANF_GetSimilarString(const input[], const candidates[][], Float:threshold = 0.111111, count = sizeof (candidates));`](#sscanf_getsimilarstringconst-input-const-candidates-floatthreshold--0111111-count--sizeof-candidates)
    * 9.16 [`SSCANF_GetSimilarValue(const input[], const candidates[][], const results[], fail = cellmin, Float:threshold = 0.111111, count = sizeof (candidates), check = sizeof (results));`](#sscanf_getsimilarvalueconst-input-const-candidates-const-results-fail--cellmin-floatthreshold--0111111-count--sizeof-candidates-check--sizeof-results)
    * 9.17 [`SSCANF_VERSION_STRING`](#sscanf_version_string)
    * 9.18 [`SSCANF_VERSION_BCD`](#sscanf_version_bcd)
    * 9.19 [`SSCANF_VERSION`](#sscanf_version-1)
    * 9.20 [`SSCANF_NO_K_VEHICLE`](#sscanf_no_k_vehicle)
    * 9.21 [`SSCANF_NO_K_WEAPON`](#sscanf_no_k_weapon)
    * 9.22 [`SSCANF_NO_NICE_FEATURES`](#sscanf_no_nice_features)
* 10 [`extract`](#extract)
* 11 [Similarity](#similarity)
* 12 [Errors/Warnings](#errorswarnings)
    * 12.1 [MSVRC100.dll not found](#msvrc100dll-not-found)
    * 12.2 [sscanf error: System not initialised](#sscanf-error-system-not-initialised)
    * 12.3 [sscanf warning: String buffer overflow.](#sscanf-warning-string-buffer-overflow)
    * 12.4 [sscanf warning: Optional types invalid in array specifiers, consider using 'A'.](#sscanf-warning-optional-types-invalid-in-array-specifiers-consider-using-a)
    * 12.5 [sscanf warning: Optional types invalid in enum specifiers, consider using 'E'.](#sscanf-warning-optional-types-invalid-in-enum-specifiers-consider-using-e)
    * 12.6 [sscanf error: Multi-dimensional arrays are not supported.](#sscanf-error-multi-dimensional-arrays-are-not-supported)
    * 12.7 [sscanf error: Search strings are not supported in arrays.](#sscanf-error-search-strings-are-not-supported-in-arrays)
    * 12.8 [sscanf error: Delimiters are not supported in arrays.](#sscanf-error-delimiters-are-not-supported-in-arrays)
    * 12.9 [sscanf error: Quiet sections are not supported in arrays.](#sscanf-error-quiet-sections-are-not-supported-in-arrays)
    * 12.10 [sscanf error: Unknown format specifier '?'.](#sscanf-error-unknown-format-specifier-)
    * 12.11 [sscanf warning: Empty default values.](#sscanf-warning-empty-default-values)
    * 12.12 [sscanf warning: Unclosed default value.](#sscanf-warning-unclosed-default-value)
    * 12.13 [sscanf warning: No default value found.](#sscanf-warning-no-default-value-found)
    * 12.14 [sscanf warning: Unenclosed specifier parameter.](#sscanf-warning-unenclosed-specifier-parameter)
    * 12.15 [sscanf warning: No specified parameter found.](#sscanf-warning-no-specified-parameter-found)
    * 12.16 [sscanf warning: Missing string length end.](#sscanf-warning-missing-string-length-end)
    * 12.17 [sscanf warning: Missing length end.](#sscanf-warning-missing-length-end)
    * 12.18 [sscanf error: Invalid data length.](#sscanf-error-invalid-data-length)
    * 12.19 [sscanf error: Invalid character in data length.](#sscanf-error-invalid-character-in-data-length)
    * 12.20 [sscanf error: String/array must include a length, please add a destination size.](#sscanf-error-stringarray-must-include-a-length-please-add-a-destination-size)
    * 12.21 [sscanf warning: Can't have nestled quiet sections.](#sscanf-warning-cant-have-nestled-quiet-sections)
    * 12.22 [sscanf warning: Not in a quiet section.](#sscanf-warning-not-in-a-quiet-section)
    * 12.23 [sscanf warning: Can't remove quiet in enum.](#sscanf-warning-cant-remove-quiet-in-enum)
    * 12.24 [sscanf error: Arrays are not supported in enums.](#sscanf-error-arrays-are-not-supported-in-enums)
    * 12.25 [sscanf warning: Unclosed string literal.](#sscanf-warning-unclosed-string-literal)
    * 12.26 [sscanf warning: sscanf specifiers do not require '%' before them.](#sscanf-warning-sscanf-specifiers-do-not-require--before-them)
    * 12.27 [sscanf error: Insufficient default values.](#sscanf-error-insufficient-default-values)
    * 12.28 [sscanf error: Options are not supported in enums.](#sscanf-error-options-are-not-supported-in-enums)
    * 12.29 [sscanf error: Options are not supported in arrays.](#sscanf-error-options-are-not-supported-in-arrays)
    * 12.30 [sscanf error: No option value.](#sscanf-error-no-option-value)
    * 12.31 [sscanf error: Unknown option name.](#sscanf-error-unknown-option-name)
    * 12.32 [sscanf warning: Could not find function SSCANF:?.](#sscanf-warning-could-not-find-function-sscanf)
    * 12.33 [sscanf error: SSCANF_Init has incorrect parameters.](#sscanf-error-sscanf_init-has-incorrect-parameters)
    * 12.34 [sscanf error: SSCANF_Join has incorrect parameters.](#sscanf-error-sscanf_join-has-incorrect-parameters)
    * 12.35 [sscanf error: SSCANF_Leave has incorrect parameters.](#sscanf-error-sscanf_leave-has-incorrect-parameters)
    * 12.36 [sscanf error: SSCANF_IsConnected has incorrect parameters.](#sscanf-error-sscanf_isconnected-has-incorrect-parameters)
	* 12.37 [sscanf error: SSCANF_Version has incorrect parameters.](#sscanf-error-sscanf_version-has-incorrect-parameters)
	* 12.38 [sscanf error: SSCANF_Option has incorrect parameters.](#sscanf-error-sscanf_option-has-incorrect-parameters)
	* 12.39 [sscanf error: SetPlayerName has incorrect parameters.](#sscanf-error-setplayername-has-incorrect-parameters)
	* 12.40 [sscanf error: Missing required parameters.](#sscanf-error-missing-required-parameters)
	* 12.41 [`fatal error 111: user error: sscanf already defined, or used before inclusion.`](#fatal-error-111-user-error-sscanf-already-defined-or-used-before-inclusion)
	* 12.42 [`error 004: function "sscanf" is not implemented`](#error-004-function-sscanf-is-not-implemented)
	* 12.43 [`error 004: function "sscanf" is not implemented - include <sscanf2> first.`](#error-004-function-sscanf-is-not-implemented---include-sscanf2-first)
	* 12.44 [sscanf error: Pawn component not loaded.](#sscanf-error-pawn-component-not-loaded)
	* 12.45 [sscanf warning: Unknown `player->setName()` return.](#sscanf-warning-unknown-player-setName-return)
	* 12.46 [sscanf error: This script was built with the component version of the include.](#sscanf-error-this-script-was-built-with-the-component-version-of-the-include)
* 13 [Future Plans](#future-plans)
    * 13.1 [Reserved Specifiers](#reserved-specifiers)
    * 13.2 [Alternates](#alternates)
    * 13.3 [Enums And Arrays](#enums-and-arrays)
    * 13.4 [Compilation](#compilation)
* 14 [Building](#building)
    * 14.1 [Getting The Code](#getting-the-code)
    * 14.2 [Building On Windows](#building-on-windows)
    * 14.3 [Building On Linux](#building-on-linux)
    * 14.4 [Building With Docker](#building-with-docker)
* 15 [License](#license)
    * 15.1 [Version: MPL 1.1](#version-mpl-11)
    * 15.2 [Contributor(s):](#contributors)
    * 15.3 [Special Thanks to:](#special-thanks-to)
* 16 [Changelog](#changelog)
    * 15.1 [sscanf 2.8.2 - 18/04/2015](#sscanf-282---18042015)
    * 15.2 [sscanf 2.8.3 - 02/10/2018](#sscanf-283---02102018)
    * 15.3 [sscanf 2.9.0 - 04/11/2019](#sscanf-290---04112019)
    * 15.4 [sscanf 2.10.0 - 27/06/2020](#sscanf-2100---27062020)
    * 15.5 [sscanf 2.10.1 - 27/06/2020](#sscanf-2101---27062020)
    * 15.6 [sscanf 2.10.2 - 28/06/2020](#sscanf-2102---28062020)
    * 15.7 [sscanf 2.10.3 - 28/04/2021](#sscanf-2103---28042021)
    * 15.8 [sscanf 2.10.4 - 17/01/2022](#sscanf-2104---17012022)
    * 15.9 [sscanf 2.11.1 - 25/01/2022](#sscanf-2111---25012022)
    * 15.9 [sscanf 2.11.2 - 04/02/2022](#sscanf-2112---04022022)
    * 15.10 [sscanf 2.11.3 - 05/02/2022](#sscanf-2113---05022022)
    * 15.10 [sscanf 2.11.4 - 02/03/2022](#sscanf-2114---02032022)
    * 15.11 [sscanf 2.11.5 - 31/03/2022](#sscanf-2115---31032022)
    * 15.12 [sscanf 2.12.1 - 05/05/2022](#sscanf-2121---05052022)
    * 15.13 [sscanf 2.12.2 - 11/05/2022](#sscanf-2122---11052022)
    * 15.14 [sscanf 2.13.1 - 25/06/2022](#sscanf-2131---25062022)
    * 15.15 [sscanf 2.13.2 - 07/09/2022](#sscanf-2132---07092022)
    * 15.16 [sscanf 2.13.3 - 04/12/2022](#sscanf-2133---04122022)
    * 15.17 [sscanf 2.13.4 - 20/12/2022](#sscanf-2134---20122022)
    * 15.18 [sscanf 2.13.5 - 28/12/2022](#sscanf-2135---28122022)
    * 15.19 [sscanf 2.13.6 - 28/12/2022](#sscanf-2136---28122022)
    * 15.20 [sscanf 2.13.7 - 02/01/2023](#sscanf-2137---02012023)
    * 15.21 [sscanf 2.13.8 - 05/01/2023](#sscanf-2138---05012023)

## Downloads

GitHub repo:

https://github.com/Y-Less/sscanf/

## Use

### Scripting

This behaves exactly as the old sscanf did, just MUCH faster and much more flexibly.  To use it add:

```pawn
#include <sscanf2>
```

To your modes and remove the old sscanf (the new include will detect the old version and throw an error if it is detected).

The basic code looks like:

```pawn
if (sscanf(params, "ui", giveplayerid, amount))
{
    return SendClientMessage(playerid, 0xFF0000AA, "Usage: /givecash <playerid/name> <amount>");
}
```

However it should be noted that sscanf can be used for any text processing you like.  For example an ini processor could look like (don't worry about what the bits mean at this stage):

```pawn
if (sscanf(szFileLine, "p<=>s[8]s[32]", szIniName, szIniValue))
{
    printf("Invalid INI format line");
}
```

There is also an alternate function name to avoid confusion with the C standard sscanf:

```pawn
if (unformat(params, "ui", giveplayerid, amount))
{
    return SendClientMessage(playerid, 0xFF0000AA, "Usage: /givecash <playerid/name> <amount>");
}
```

### open.mp

The `sscanf` binary (`sscanf.dll` on Windows, or `sscanf.so` on Linux) works as both a legacy (SA:MP) plugin or an *open.mp* component.  The recommended method is to use it as a component - just place the file in the `components` directory in the server root and *open.mp* will load it automatically.

If you wish to use it as a legacy plugin for some reason (there is no need if you are on version `2.12.1` or higher) place it in the `plugins` directory in the open.mp server root and either follow the *SA:MP*-specific instructions for `server.cfg` on your platform or add `"sscanf"` to `"pawn.legacy_plugins"` in `config.json`:

```json
{
	"pawn":
	{
		"legacy_plugins":
		[
			"sscanf"
		]
	}
}
```

### SA:MP Windows

Add `sscanf` to the start of the `plugins` line in `server.cfg`.  For example:

```
plugins sscanf streamer crashdetect
```

If there isn't a `plugins` line already, add one:

```pawn
plugins sscanf
```

You must also place `sscanf.dll` in the `plugins` subdirectory of the server.  If there isn't a `plugins` directory, create one.

### SA:MP Linux

Add `sscanf.so` to the start of the `plugins` line in `server.cfg`.  For example:

```
plugins sscanf.so streamer.so crashdetect.so
```

If there isn't a `plugins` line already, add one:

```pawn
plugins sscanf.so
```

You must also place `sscanf.so` in the `plugins` subdirectory of the server.  If there isn't a `plugins` directory, create one.

### NPC modes

To use sscanf in an NPC mode save the plugin as `amxsscanf.dll` (on Windows) or `amxsscanf.so` (on Linux) in the same directory as `samp-npc(.exe)` (i.e. the server root).  This allows NPC modes to automatically find and load the library.  The only tiny differences between this sscanf and the normal sscanf are that there are no prints; and `u`, `r`, and `q` don't know if a user is a bot or not thus just assume they are all players.

## Tutorials

### `/sendcash` Command

Send some of your money to another player.  This command allows you to specify the target player using their name or ID so you can type `/sendcash Y_Less 500` to send me $500 (*hint hint...*), or `/sendcash 27 12` to send $12 to whoever player ID 27 is.  Note that if a player has a numeric name such as `69` you will have to use their ID only, typing that name will always select the player with ID 69, not the player with name "69":

```pawn
YCMD:sendcash(playerid, params[], help)
{
	if (help)
	{
		SendClientMessage(playerid, COLOUR_HELP, "Send money to another player.  Usage: /sendcash <name/id> <amount>");
		return 1;
	}
	new targetid, money;
	if (sscanf(params, "ui", targetid, money) != 0)
	{
		SendClientMessage(playerid, COLOUR_HELP, "Missing parameters.  Usage: /sendcash <name/id> <amount>");
		return 1;
	}
	if (targetid == INVALID_PLAYER_ID)
	{
		SendClientMessage(playerid, COLOUR_HELP, "Unknown target player.");
		return 1;
	}
	if (money > GetPlayerMoney(playerid))
	{
		SendClientMessage(playerid, COLOUR_HELP, "You don't have enough money.");
		return 1;
	}
	GivePlayerMoney(playerid, -money);
	GivePlayerMoney(targetid, money);
	SendClientMessage(playerid, COLOUR_HELP, "You sent money.");
	SendClientMessage(targetid, COLOUR_HELP, "You receieved money.");
	return 1;
}
```

### INI Parser

This very basic file reader uses *sscanf* to split the keys and values in an INI file by `=`.

```pawn
bool:ReadINIString(const filename[], const key[], &value)
{
	new File:f = fopen(filename, io_read);
	if (!f)
	{
		return false;
	}
	new line[128];
	new k[32], v[96];
	while ((fread(f, line)))
	{
		if (sscanf(line, "p<=>s[32]s[96]", k, v) == 0)
		{
			if (strcmp(key, k, true) == 0)
			{
				value = strval(v);
				fclose(f);
				return true;
			}
		}
	}
	fclose(f);
	return false;
}
```

## Specifiers

The basic specifiers (the letters `u`, `i`, `s` etc. in the codes above) here.  There are more advanced ones in a later table.

|  Specifier(s)  |               Name                |                      Example values                       |
| -------------- | --------------------------------- | --------------------------------------------------------- |
|  `i`, `d`      |  Integer                          |  `1`, `42`, `-10`                                         |
|  `c`           |  Character                        |  `a`, `o`, `*`                                            |
|  `l`           |  Logical                          |  `true`, `false`                                          |
|  `b`           |  Binary                           |  `01001`, `0b1100`                                        |
|  `h`, `x`      |  Hex                              |  `1A`, `0x23`                                             |
|  `o`           |  Octal                            |  `045`, `12`                                              |
|  `n`           |  Number                           |  `42`, `0b010`, `0xAC`, `045`                             |
|  `f`           |  Float                            |  `0.7`, `-99.5`                                           |
|  `g`           |  IEEE Float                       |  `0.7`, `-99.5`, `INFINITY`, `-INFINITY`, `NAN`, `NAN_E`  |
|  `u`           |  User name/id (bots and players)  |  `Y_Less`, `0`                                            |
|  `q`           |  Bot name/id                      |  `ShopBot`, `27`                                          |
|  `r`           |  Player name/id                   |  `Y_Less`, `42`                                           |
|  `m`           |  Colour                           |  `{FF00AA}`, `0xFFFFFFFF`, `444`                          |

### Strings

The specifier `s` is used, as before, for strings - but they are now more advanced.  As before they support collection, so doing:

```pawn
sscanf("hello 27", "si", str, val);
```

Will give:

```
hello
27
```

Doing:

```pawn
sscanf("hello there 27", "si", str, val);
```

Will fail as `there` is not a number.  However doing:

```pawn
sscanf("hello there", "s", str);
```

Will give:

```
hello there
```

Because there is nothing after `s` in the specifier, the string gets everything.  To stop this simply add a space:

```pawn
sscanf("hello there", "s ", str);
```

Will give:

```
hello
```

You can also escape parts of strings with `\\` - note that this is two backslashes as 1 is used by the compiler:

```pawn
sscanf("hello\\ there 27", "si", str, val);
```

Will give:

```
hello there
27
```

All these examples however will give warnings in the server as the new version has array sizes.  The above code should be:

```pawn
new
    str[32],
    val;
sscanf("hello\\ there 27", "s[32]i", str, val);
```

As you can see - the format specifier now contains the length of the target string, ensuring that you can never have your strings overflow and cause problems.  This can be combined with the SA:MP compiler's stringizing:

```pawn
#define STR_SIZE 32
new
    str[STR_SIZE],
    val;
sscanf("hello\\ there 27", "s
#STR_SIZE "]i", str, val);
```

Or better yet, you can now use `[*]` to pass a string length as an additional parameter (see "Provided Lengths" below).

So when you change your string size you don't need to change your specifiers.

### Packed Strings

`z` and `Z` return packed strings.  They are otherwise identical to `s` and `S`, so see the `Strings` documentation above for more details.

### Arrays

One of the advanced new specifiers is `a`, which creates an array, obviously.  The syntax is similar to that of strings and, as you will see later, the delimiter code:

```pawn
new
    arr[5];
sscanf("1 2 3 4 5", "a<i>[5]", arr);
```

The `a` specifier is immediately followed by a single type enclosed in angle brackets - this type can be any of the basic types listed above.  It is the followed, as with strings now, by an array size.  The code above will put the numbers 1 to 5 into the 5 indexes of the `arr` array variable.

Arrays can now also be combined with strings (see below), specifying the string size in the array type:

```
a<s[10]>[12]
```

This will produce an array of 12 strings, each up to 10 characters long (9 + NULL).  Optional string arrays still follow the optional array syntax:

```
A<s[10]>(hello)[12]
```

However, unlike numbers you can't specify a progression and have it fill up.  This code:

```
A<i>(0, 1)[4]
```

Will by default produce:

```
0, 1, 2, 3
```

However, this code:

```
A<s[10]>(hi, there)[4]
```

Will by default produce:

```
"hi, there", "hi, there", "hi, there", "hi, there"
```

As normal, you can add brackets in to the default string value with `\)`:

```
A<s[10]>(hi (code\))[4]
```

It should also be noted that there is NO length checking on default strings.  If you do:

```
A<s[10]>(This is longer than 10 characters)[4]
```

You will probably just corrupt the PAWN stack.  The length checking is to ensure no users enter malicious data; however, in this case it is up to the scripter to ensure that the data is correct as they are the only one affecting it and shouldn't be trying to crash their own server.  Interestingly, arrays of strings actually also work with jagged arrays and arrays that have been shuffled by Slice's quicksort function (this isn't a side-effect, I specifically wrote them to do so).

### Enums

This is possibly the most powerful addition to sscanf ever.  This gives you the ability to define the structure of an enum within your specifier string and read any data straight into it.  The format takes after that of arrays, but with more types - and you can include strings in enums (but not other enums or arrays):

```pawn
enum
    E_DATA
{
    E_DATA_C,
    Float:E_DATA_X,
    E_DATA_NAME[32],
    E_DATA_Z
}

main
{
    new
        var[E_DATA];
    sscanf("1 12.0 Bob c", "e<ifs[32]c>", var);
}
```

Now I'll be impressed if you can read that code straight off, so I'll explain it slowly:

```pawn
e - Start of the `enum` type
< - Starts the specification of the structure of the enum
i - An integer, corresponds with E_DATA_C
f - A float, corresponds with E_DATA_X
s[32] - A 32 cell string, corresponds with E_DATA_NAME
c - A character, corresponds with E_DATA_Z
> - End of the enum specification
```

Note that an enum doesn't require a size like arrays and strings - it's size is determined by the number and size of the types.  Most, but not all, specifiers can be used inside enums (notably arrays and other enums can't be).

### Provided Lengths

Both strings and arrays take a length, normally specified in the string with (say) `s[32]`.  However, this system has some extreme limitations - most notably macros.  This code will not work:

```pawn
#define LEN 32
sscanf(params, "s[LEN]", str);
```

This code will work:

```pawn
#define LEN 32
sscanf(params, "s["#LEN"]", str);
```

But this code won't even compile due to a compiler issue stringifying brackets before version 3.10.11.

```pawn
#define LEN (32)
sscanf(params, "s["#LEN"]", str);
```

This code will work, but is a bit awkward:

```pawn
sscanf(params, "s[(32)]", str);
```

This code will compile, but then also won't work:

```pawn
#define LEN 8*4
sscanf(params, "s["#LEN"]", str);
```

For this reason you can pass string and array lengths as additional parameters using `*` for the length:

```pawn
#define LEN 8*4
sscanf(params, "s[*]", LEN, str);
```

The lengths appear BEFORE the destination, arrays first then strings:

```pawn
new int, arr[5][10], str[32];
sscanf(params, "ia<s[*]>[*]s[*]", int, sizeof (arr), sizeof (arr[]), arr, 32, str);
```

There are three main specifiers here - `i`, `a<s[*]>[*]`, and `s[*]`; and each is handled entirely independently.  So the first parameter (`int`) is for `i`, the next three (`sizeof (arr), sizeof (arr[]), arr`) are for `a<s[*]>[*]`, and the final two (`32, str`) are for `s[*]`.  The first and last are easy to understand, the second one not so much.  The sizes are in reverse order, outer to inner, so `sizeof (arr)` is for the `*` in the outer `a<...>[*]` and `sizeof (arr[])` is for the `*` in the inner `s[*]`  Then the destination variable is given after all information about the specifier has been derived.

The same applies to strings in enums:

```pawn
enum E_EXAMPLE
{
	Float:FLOAT,
	STR_1[32],
	STR_2[64],
	INT,
}

new dest[E_EXAMPLE];
sscanf(params, "e<fs[*]s[*]i>", _:STR_2 - _:STR_1, 64, dest);
```

And to arrays of users (see below):

```pawn
new ids[3], i;
sscanf(params, "u[*]", sizeof (ids), ids);
```

This allows you to pass variable lengths if you don't want to use all of a string, and use the full power of the pre-processor to generate lengths at compile-time.  It also bypasses the compiler stringise bug with brackets in strings.  `extract` (see below) now uses `*` for all strings and arrays as well, so will similarly fully use the pre-processor.

### Quiet

The two new specifiers `{` and `}` are used for what are known as `quiet` specifiers.  These are inputs which are read and checked, but not saved.  For example:

```pawn
sscanf("42 -100", "{i}i", var);
```

Clearly there are two numbers and two `i`, but only one return variable.  This is because the first `i` is quiet so is not saved, but affects the return value.  The code above makes `var` `-100`.  The code below will fail in an if check:

```pawn
sscanf("hi -100", "{i}i", var);
```

Although the first integer is not saved it is still read - and `hi` is not an integer.  Quiet zones can be as long as you like, even for the whole string if you only want to check values are right, not save them:

```pawn
sscanf("1 2 3", "i{ii}", var);
sscanf("1 2 3", "{iii}");
sscanf("1 2 3", "i{a<i>[2]}", var);
```

You can also embed quiet sections inside enum specifications:

```pawn
sscanf("1 12.0 Bob 42 INFINITY c", "e<ifs[32]{ig}c>", var);
```

Quiet sections cannot contain other quiet sections, however they can include enums which contain quiet sections.

### Searches

Searches were in the last version of sscanf too, but I'm explaining them again anyway.  Strings enclosed in single quotes (') are scanned for in the main string and the position moved on.  Note that to search for a single quote you escape it as above using `\\`:

```pawn
sscanf("10 11 woo 12", "i'woo'i", var0, var1);
```

Gives:

```
10
12
```

You could achieve the same effect with:

```pawn
sscanf("10 11 woo 12", "i{is[1000]}i", var0, var1);
```

But that wouldn't check that the string was `woo`.  Also note the use of `1000` for the string size.  Quiet strings must still have a length, but as they aren't saved anywhere you can make this number as large as you like to cover any eventuality.  Enum specifications can include search strings.

### Enums

This is a feature similar to quiet sections, which allows you to skip overwriting certain parts of an enum:

```
e<ii-i-ii>
```

Here the `-` is a `minus`, and tells sscanf that there is an enum element there, but not to do anything, so if you had:

```pawn
enum E
{
    E_A,
    E_B,
    E_C,
    E_D,
    E_E
}
```

And you only wanted to update the first two and the last fields and leave all others untouched you could use that specifier above.  This way sscanf knows how to skip over the memory, and how much memory to skip.  Note that this doesn't read anything, so you could also combine this with quiet sections:

```
e<ii-i-i{ii}i>
```

That will read two values and save them, skip over two memory locations, read two values and NOT save them, then read and save a last value.  In this way you can have written down all the values for every slot in the enum, but have only used 3 of them.  Note that this is the same with `E` - if you do:

```
E<ii-i-ii>
```

You should ONLY specify THREE defaults, not all five:

```
E<ii-i-ii>(11, 22, 55)
```

### Delimiters

The previous version of sscanf had `p` to change the symbol used to separate tokens.  This specifier still exists but it has been formalised to match the array and enum syntax.  What was previously:

```pawn
sscanf("1,2,3", "p,iii", var0, var1, var2);
```

Is now:

```pawn
sscanf("1,2,3", "p<,>iii", var0, var1, var2);
```

The old version will still work, but it will give a warning.  Enum specifications can include delimiters, and is the only time `<>`s are contained in other `<>`s:

```pawn
sscanf("1 12.0 Bob,c", "e<ifp<,>s[32]c>", var);
```

Note that the delimiter will remain in effect after the enum is complete.  You can even use `>` as a specifier by doing `p<\>>` (or the older `p>`).

When used with strings, the collection behaviour is overruled.  Most specifiers are still space delimited, so for example this will work:

```pawn
sscanf("1 2 3", "p<;>iii", var0, var1, var2);
```

Despite the fact that there are no `;`s.  However, strings will ONLY use the specified delimiters, so:

```pawn
sscanf("hello 1", "p<->s[32]i", str, var);
```

Will NOT work - the variable `str` will contain `hello 1`.  On the other hand, the example from earlier, slightly modified:

```pawn
sscanf("hello there>27", "p<>>s[32]i", str, var);
```

WILL work and will give an output of:

```
hello there
27
```

You can now have optional delimiters using `P` (upper case `p` to match other `optional` specifiers).  These are optional in the sense that you specify multiple delimiters and any one of them can be used to end the next symbol:

```pawn
sscanf("(4, 5, 6, 7)", "P<(),>{s[2]}iiii", a, b, c, d);
```

This uses a `quiet section` to ignore anything before the first `(`, and then uses multiple delimiters to end all the text.  Example:

```pawn
sscanf("42, 43; 44@", "P<,;@>a<i>[3]", arr);
```

### Optional specifiers

EVERY format specifier (that is, everything except `''`, `{}` and `p`) now has an optional equivalent - this is just their letter capitalised.  In addition to optional specifiers, there are also now default values:

```pawn
sscanf("", "I(12)", var);
```

The `()`s (round brackets) contain the default value for the optional integer and, as the main string has no data, the value of `var` becomes `12`.  Default values come before array sizes and after specifications, so an optional array would look like:

```pawn
sscanf("1 2", "A<i>(3)[4]", arr);
```

Note that the size of the array is `4` and the default value is `3`.  There are also two values which are defined, so the final value of `arr` is:

```
1, 2, 3, 3
```

Array default values are clever, the final value of:

```pawn
sscanf("", "A<i>(3,6)[4]", arr);
```

Will be:

```
3, 6, 9, 12
```

The difference between `3` and `6` is `3`, so the values increase by that every index.  Note that it is not very clever, so:

```pawn
sscanf("", "A<i>(1,2,2)[4]", arr);
```

Will produce:

```
1, 2, 2, 2
```

The difference between `2` and `2` (the last 2 numbers in the default) is 0, so there will be no further increase.  For `l` (logical) arrays, the value is always the same as the last value, as it is with `g` if the last value is one of the special values (INFINITY, NEG_INFINITY (same as -INFINITY), NAN or NAN_E).  Note that:

```pawn
sscanf("", "a<I>(1,2,2)[4]", arr);
```

Is invalid syntax, the `A` must be the capital part.

Enums can also be optional:

```pawn
sscanf("4", "E<ifs[32]c>(1, 12.0, Bob, c)", var);
```

In that code all values except `4` will be default.  Also, again, you can escape commas with `\\` in default enum strings.  Some final examples:

```pawn
sscanf("1", "I(2)I(3)I(4)", var0, var1, var2);
sscanf("", "O(045)H(0xF4)B(0b0100)U(Y_Less)", octnum, hexnum, binnum, user);
sscanf("0xFF", "N(0b101)");
```

That last example is of a specifier not too well described yet - the `number` specifier, which will work out the format of the number from the leading characters (0x, 0b, 0 or nothing).  Also note that the second example has changed - see the next section.

### Users

The `u`, `q`, and `r` specifiers search for a user by name or ID.  The method of this search has changed in the latest versions of `sscanf`.

Additionally `U`, `Q`, and `R` used to take a name or ID as their default value - this has since been changed to JUST a number, and sscanf will not try and determine if this number is online:

Previous:

```pawn
sscanf(params, "U(Y_Less)", id);
if (id == INVALID_PLAYER_ID)
{
    // Y_Less or the entered player is not connected.
}
```

New:

```pawn
sscanf(params, "U(-1)", id);
if (id == -1)
{
    // No player was entered.
}
else if (id == INVALID_PLAYER_ID)
    // Entered player is not connected.
}
```

See the section on options for more details.

Users can now optionally return an ARRAY of users instead of just one.  This array is just a list of matched IDs, followed by `INVALID_PLAYER_ID`.  Given the following players:

```
0) Y_Less
1) [CLAN]Y_Less
2) Jake
3) Alex
4) Hass
```

This code:

```pawn
new ids[3], i;
if (sscanf("Le", "?<MATCH_NAME_PARTIAL=1>u[3]", ids)) printf("Error in input");
for (i = 0; ids[i] != INVALID_PLAYER_ID; ++i)
{
    if (ids[i] == cellmin)
    {
        printf("Too many matches");
        break;
    }
    printf("id = %d", ids[i]);
}
if (i == 0) printf("No matching players found.");
```

Will output:

```
id = 0
id = 1
Too many matches
```

Searching `Les` instead will give:

```
id = 0
id = 1
```

And searching without `MATCH_NAME_PARTIAL` will give:

```
No matching players found.
```

Basically, if an array of size `N` is passed, this code will return the first N-1 results.  If there are less than `N` players whose name matches the given name then that many players will be returned and the next slot will be `INVALID_PLAYER_ID` to indicate the end of the list.  On the other hand if there are MORE than `N - 1` players whose name matches the given pattern, then the last slot will be `cellmin` to indicate this fact.

When combined with `U` and returning the default, the first slot is always exactly the default value (even if that's not a valid connected player) and the next slot is always `INVALID_PLAYER_ID`.

Note also that user arrays can't be combined with normal arrays or enums, but normal single-return user specifiers still can be.

Just like with array sizes you can use `*` to pass an additional variable for the default, so you can do:

```pawn
sscanf(params, "I(*)", INVALID_ID, output);
```

As with arrays the default value comes *before* the output value in the parameter list.  When combined with `[*]` the order is *default*, then *size*, then *output*:

```pawn
sscanf(params, "A<i>(*)[*]", DEFAULT_VALUE, ARRAY_SIZE, output);
```

String defaults can use `\` to escape `)` or `*` within them if you want a string to contain those values.

However, currently neither arrays nor strings use the value from the `*` parameter, but both will still skip the parameter.

### Custom (kustom) specifiers

The latest version of sscanf adds a new `k` specifier to allow you to define your own specifers in PAWN:

```pawn
sscanf(params, "uk<playerstate>", playerid, state);
```

`k<playerstate>` allows you to type a number or the textual name of a player state.  To convert this string name to a value we need a conversion function:

```pawn
@kustom() playerstate(string[])
{
    if ('0' <= string[0] <= '9')
    {
        new
            ret = strval(string);
        if (0 <= ret <= 9)
        {
            return ret;
        }
    }
    else if (!strcmp(string, "PLAYER_STATE_NONE")) return 0;
    else if (!strcmp(string, "PLAYER_STATE_ONFOOT")) return 1;
    else if (!strcmp(string, "PLAYER_STATE_DRIVER")) return 2;
    else if (!strcmp(string, "PLAYER_STATE_PASSENGER")) return 3;
    else if (!strcmp(string, "PLAYER_STATE_WASTED")) return 7;
    else if (!strcmp(string, "PLAYER_STATE_SPAWNED")) return 8;
    else if (!strcmp(string, "PLAYER_STATE_SPECTATING")) return 9;
}
```

The code above, when added to the top level of your mode, will add the `playerstate` specifier used in `k<playerstate>`.  With this a user can either type a number or the full name of a state and the function will convert the name or number to a number.

This system supports optional custom specifiers (`K`) with no additional PAWN code.  This optional kustom specifier takes a default value that is NOT (as of sscanf 2.8) parsed by the given callback:

```pawn
sscanf(params, "uK<playerstate>(0)", playerid, state);
```

So in this example `999` is NOT a valid vehicle model, but if no other value is supplied then 999 will be returned, allowing you to differentiate between the user entering an invalid vehicle and not entering anything at all:

```
K<vehicle>(999)
```

The new version of `sscanf2.inc` includes functions for `k<weapon>` and `k<vehicle>` allowing you to enter either the ID or name and get the ID back, but both are VERY basic at the moment and I expect other people will improve on them.

Note that custom specifiers always take a string input and always return a number, but this can be a Float, bool, or any other single cell tag type.

Also as of sscanf 2.8, `k` can be used in both arrays and enums.  Prior to sscanf 2.13.3 `@kustom()` was `SSCANF:`; [this is bad for many reasons](https://github.com/pawn-lang/YSI-Includes/blob/5.x/annotations.md) but the old version still works of course (because backwards compatibility is important).

### Colours

sscanf 2.10.0 introduced colours in addition to normal hex numbers.  They are parsed almost identically, but have slightly more constraints on their forms.  Colours must be HEX values exactly 3, 6, or 8 digits long.  3 digit numbers are as in CSS - `#RGB` becomes `0xRRGGBBAA` with default alpha, 6 digit numbers are already `0xRRGGBBAA` with default alpha, 8 digit numbers are the full colour with alpha.  The default default alpha is `255` (`FF`), but this can be changed with the `SSCANF_ALPHA` option; for example setting the default alpha to `AA` would be `?<SSCANF_ALPHA=170>`.  Why do they use `m`, not some sane letter?  Simple - all the good descriptive letters were already used.

The different lengths have slightly different semantics in what is accepted, to reduce the changes of incorrect values being parsed.  You can also customise exactly which input types you accept with the `SSCANF_COLOUR_FORMS` option.

#### 3 digits

A 3-digit hex value MUST be prefixed with `#` as in CSS, and each component is multiplied by `0x11` to give the final component value.  `#FAB` would become `0xFFAABBFF`, `#123` would become `0x112233FF`, `000` would be rejected because there is no `#`.

#### 6 digits

A 6-digit hex colour MAY be prefixed by `#` as in CSS, but doesn't have to be; it can also be prefixed by `0x` or nothing at all.  `#123456`, `0x123456`, and `123456` are all the same value, all valid, and will all give an output of `0x123456FF` with the default alpha value.  Furthermore, a 6-digit hex value may be optionally enclosed in `{}`s - `{8800DD}` is valid, but no other length in `{}`s are valid.

More valid examples:

* `FFFFFF`
* `0x000000`
* `0x010101`
* `#EEEEEE`
* `{000000}`

More invalid examples:

* `FFFFFFF` - 7 digits
* `0x00000` - 5 digits
* `#EEEE` - 4 digits
* `{}` - 0 digits
* `{BBB}` - 3 digits, but not `#` prefix
* `{12345678}` - 8 digits, but inside `{}`s`
* `{123456` - 6 digits, but no closing `}`.

#### 8 digits

8-digit colours are the simplest - the alpha is specified explicitly and there are only two possible input forms - `0x` prefix and no prefix.  I.e. either `0x88995566` or `88995566`.

## Options

The latest version of sscanf introduces several options that can be used to customise the way in which sscanf operates.  There are two ways of setting these options - globally and locally:

```pawn
SSCANF_Option(SSCANF_QUIET, 1);
```

This sets the `SSCANF_QUIET` option globally.  Every time `sscanf` is called the option (see below) will be in effect.  Note that the use of `SSCANF_QUIET` instead of the string `"SSCANF_QUIET"` is entirely valid here - all the options are defined in the sscanf2 include already (but you can use the string if you want).

Alternatively you can use `?` to specify an option locally - i.e. only for the current sscanf call:

```pawn
sscanf(params, "si", str, num);
sscanf(params, "?<SSCANF_QUIET=1>si", str, num);
sscanf(params, "si", str, num);
```

`s` without a length is wrong, and the first and last `sscanf` calls will give an error in the console, but the second one won't as for just that one call prints have been disabled.  The following code disables prints globally then enables them locally:

```pawn
SSCANF_Option(SSCANF_QUIET, 1);
sscanf(params, "si", str, num);
sscanf(params, "?<SSCANF_QUIET=0>si", str, num);
sscanf(params, "si", str, num);
```

Note that disabling prints is a VERY bad idea when developing code as you open yourself up to unreported buffer overflows when no length is specified on strings.

To specify multiple options requires multiple calls:

```pawn
SSCANF_Option(SSCANF_QUIET, 1);
SSCANF_Option(MATCH_NAME_PARTIAL, 0);
sscanf(params, "?<SSCANF_QUIET=1>?<MATCH_NAME_PARTIAL=0>s[10]i", str, num);
```

You can also read the current value of an option by ommitting the second parameter:

```pawn
new quiet = SSCANF_Option(SSCANF_QUIET);
```

The options are:

### OLD_DEFAULT_NAME:

The behaviour of `U`, `Q`, and `R` have been changed to take any number as a default, instead of a connected player.  Setting `OLD_DEFAULT_NAME` to `1` will revert to the old version.

### MATCH_NAME_PARTIAL:

Currently sscanf will search for players by name, and will ALWAYS search for player whose name STARTS with the specified string.  If someone types `Y_Less`, sscanf will not find say `[CLAN]Y_Less` because there name doesn't start with the specified text.  This option, when set to 1, will search ANYWHERE in the player's name for the given string.

### CELLMIN_ON_MATCHES:

Whatever the value of `MATCH_NAME_PARTIAL`, the first found player will always be returned, so if you do a search for `_` on an RP server, you could get almost anyone.  To detect this case, if more than one player will match the specified string then sscanf will return an ID of `cellmin` instead.  This can be combined with `U` for a lot more power:

```pawn
sscanf(params, "?<CELLMIN_ON_MATCHES=1>U(-1)", id);
if (id == -1)
{
	// No player was entered.
}
else if (id == cellmin)
{
	// Multiple matches found
}
else if (id == INVALID_PLAYER_ID)
{
	// Entered player is not connected.
}
else
{
	// Found just one player.
}
```

### SSCANF_QUIET:

Don't print any errors to the console.  REALLY not recommended unless you KNOW your code is stable and in production.

### OLD_DEFAULT_KUSTOM:

As with `U`, `K` used to require a valid identifier as the default and would parse it using the specified callback, so this would NOT work:

```
K<vehicle>(Veyron)
```

Because that is not a valid vehicle name in GTA.  The new version now JUST takes a number and returns that regardless:

```
K<vehicle>(9999)
```

This setting reverts to the old behaviour.

### SSCANF_ALPHA:

Specify the default alpha value for colours (`m`) which don't manually specify an alpha channel.  The alpha values are specified as a ***DECIMAL*** number, ***NOT*** a ***HEX*** number, so setting an alpha of `0x80` would be:

```pawn
SSCANF_Option(SSCANF_ALPHA, 128);
```

### SSCANF_COLOUR_FORMS:

There are multiple valid colour input formats, which you can enable or disable here.  The parameter is a bit map (flags) for all the following values:

* `1` - `#RGB`
* `2` - `#RRGGBB`
* `4` - `0xRRGGBB`
* `8` - `RRGGBB`
* `16` - `{RRGGBB}`
* `32` - `0xRRGGBBAA`
* `64` - `RRGGBBAA`

So to ONLY accept SA:MP `SendClientMessage` colours use:

```pawn
SSCANF_Option(SSCANF_COLOUR_FORMS, 16);
```

To only accept 8-digit values use:

```pawn
SSCANF_Option(SSCANF_COLOUR_FORMS, 96);
```

Default values (those specified between `()`s for `M`) ignore this setting - they can always use any form.

### SSCANF_ARGB:

Specify whether the returned colour is `ARGB` or `RGBA`:

```pawn
SSCANF_Option(SSCANF_ARGB, 1); // Set 3- and 6-digit colour outputs to `AARRGGBB`.
SSCANF_Option(SSCANF_ARGB, 0); // Set 3- and 6-digit colour outputs to `RRGGBBAA` (default).
```

### MATCH_NAME_FIRST:

Will return the first match to a name input, instead of the best.  So if there are players `Bob255` and `Bob7`, and the input is `Bob`, then the result will depend on ID order.  This matches the old behaviour.

### MATCH_NAME_SIMILARITY:

Use the same text similarity metrics as in kustom matchers to find the best name match to a given input.  The value given is the cutoff threshold for matches.  A value of `-1` disables this setting:

```pawn
sscanf("Y_Lass", "?<MATCH_NAME_SIMILARITY=0.3>u", id);
```

Will probably find `Y_Less` as the closest matching name.  A similarity of `1.0` would return only exact matches; a similarity of `0.0` will always return something, even if the input is total gibberish.  When set (i.e. not `-1`) this option overrides `MATCH_NAME_PARTIAL`, but works well with all the other name matching options.  This is the only float option, and so needs a tag override to read:

```pawn
new Float:similarity = Float:SSCANF_Option(MATCH_NAME_SIMILARITY);
```

## All specifiers

For quick reference, here is a list of ALL the specifiers and their use:

|                  Format                  |                   Use                  |
| ---------------------------------------- | -------------------------------------- |
|  `A<type>(default)[length]`              |  Optional array of given type          |
|  `a<type>[length]`                       |  Array of given type                   |
|  `B(binary)`                             |  Optional binary number                |
|  `b`                                     |  Binary number                         |
|  `C(character)`                          |  Optional character                    |
|  `c`                                     |  Character                             |
|  `D(integer)`                            |  Optional integer                      |
|  `d`                                     |  Integer                               |
|  `E<specification>(default)`             |  Optional enumeration of given layout  |
|  `e<specification>`                      |  Enumeration of given layout           |
|  `F(float)`                              |  Optional floating point number        |
|  `f`                                     |  Floating point number                 |
|  `G(float/INFINITY/-INFINITY/NAN/NAN_E)` |  Optional float with IEEE definitions  |
|  `g`                                     |  Float with IEEE definitions           |
|  `H(hex value)`                          |  Optional hex number                   |
|  `h`                                     |  Hex number                            |
|  `I(integer)`                            |  Optional integer                      |
|  `i`                                     |  Integer                               |
|  `K<callback>(any format number)`        |  Optional custom operator              |
|  `k<callback>`                           |  Custom operator                       |
|  `L(true/false)`                         |  Optional logical truthity             |
|  `l`                                     |  Logical truthity                      |
|  `M(hex value)`                          |  Optional colour                       |
|  `m`                                     |  Colour                                |
|  `N(any format number)`                  |  Optional number                       |
|  `n`                                     |  Number                                |
|  `O(octal value)`                        |  Optional octal value                  |
|  `o`                                     |  Octal value                           |
|  `P<delimiters>`                         |  Multiple delimiters change            |
|  `p<delimiter>`                          |  Delimiter change                      |
|  `Q(any format number)`                  |  Optional bot (bot)                    |
|  `q`                                     |  Bot (bot)                             |
|  `R(any format number)`                  |  Optional player (player)              |
|  `r`                                     |  Player (player)                       |
|  `S(string)[length]`                     |  Optional string                       |
|  `s[length]`                             |  String                                |
|  `U(any format number)`                  |  Optional user (bot/player)            |
|  `u`                                     |  User (bot/player)                     |
|  `X(hex value)`                          |  Optional hex number                   |
|  `x`                                     |  Hex number                            |
|  `Z(string)[length]`                     |  Optional packed string                |
|  `z[length]`                             |  Packed string                         |
|  `'string'`                              |  Search string                         |
|  `{`                                     |  Open quiet section                    |
|  `}`                                     |  Close quiet section                   |
|  `%`                                     |  Deprecated optional specifier prefix  |
|  `?`                                     |  Local options specifier               |

## Full API

### `sscanf(const data[], const format[], {Float, _}:...);`

The main sscanf function.

### `unformat(const data[], const format[], {Float, _}:...);`

An alternate name for the main `sscanf` function, since the sscanf format specifiers do not conform
to the C API of the same name.

### `SSCANF_Option(const name[], value);`

Set an option.

### `SSCANF_Option(const name[]);`

Get an option.

### `SSCANF_SetOption(const name[], value);`

Set an option explicitly (no overloaded `SSCANF_Option` call).

### `SSCANF_GetOption(const name[], value);`

Get an option explicitly (no overloaded `SSCANF_Option` call).

### `SSCANF_Version(version[], size = sizeof (version));`

Get the SSCANF plugin version as a string (e.g. `"2.11.2"`).  Compare to the macro `SSCANF_VERSION_STRING`.

### `SSCANF_Version();`

Get the SSCANF plugin version as binary coded decimal (BCD) number (e.g. `0x021003`).  Compare to the macro `SSCANF_VERSION_BCD`.

### `SSCANF_VersionString(version[], size = sizeof (version));`

Get the SSCANF plugin version as a string explicitly (no overloaded `SSCANF_Version` call).

### `SSCANF_VersionBCD();`

Get the SSCANF plugin version as BCD explicitly (no overloaded `SSCANF_Version` call).

### `SSCANF_Levenshtein(const string1[], const string2[]);`

Computes the [Levenshtein Distance](https://en.wikipedia.org/wiki/Levenshtein_distance) between the two input strings.  Useful in `k` callback functions to determine if the entered string is close to a possible string.

### `Float:SSCANF_TextSimilarity(const string1[], const string2[]);`

This works out the similarity between two strings.  The Levenshtein distance often produces results that seem weird to people, for example by that measure `NRG` is closer to `TUG` than `NRG-500`.  Instead this function uses various other (unfixed) algorithms; currently comparing all pairs of letters between the two strings to work out what percentage of each string is in the other string, then multiplying the results to get the final similarity.  This algorithm produces much more human sane results, and can handle things like `ls police` matching`Police Car (LSPD)`.  It ignores all punctuation and case as well.

### `SSCANF_GetClosestString(const input[], const candidates[][], threshold = cellmax, count = sizeof (candidates));`

Takes an input string and an array of string possibilities (candidates) and returns the index of the string closest to the input string.  If no valid match is found, `-1` is returned.  Note that this will always return the closest, even if the closest is not that close; which is why an optional `threshold` parameter is available.  When this parameter is provided the closest match must be closer in Levenshtein distance than the threshold, otherwise again `-1` is returned.  Deprecated in favour of `SSCANF_GetSimilarString`.

### `SSCANF_GetClosestValue(const input[], const candidates[][], const results[], fail = cellmin, threshold = cellmax, count = sizeof (candidates), check = sizeof (results));`

Similar to [`SSCANF_GetClosestString`](#sscanf_getcloseststringconst-input-const-candidates-threshold--cellmax-count--sizeof-candidates) in that it searches the `candidates` array for the string most closely matching the `input` and bounded by `threshold`.  But instead of returning the index this function returns the value in the second `results` array at that index; and instead of returning `-1` on failure it returns the value of `fail`.  The two arrays must match in size and an `assert` in the function checks for this.  Deprecated in favour of `SSCANF_GetSimilarValue`.

### `SSCANF_GetSimilarString(const input[], const candidates[][], Float:threshold = 0.111111, count = sizeof (candidates));`

Like `SSCANF_GetClosestString`, but using a more human-friendly text comparison function.

### `SSCANF_GetSimilarValue(const input[], const candidates[][], const results[], fail = cellmin, Float:threshold = 0.111111, count = sizeof (candidates), check = sizeof (results));`

Like `SSCANF_GetClosestValue`, but using a more human-friendly text comparison function.

### `SSCANF_VERSION_STRING`

The SSCANF include version as a string.

### `SSCANF_VERSION_BCD`

The SSCANF include version as BCD, as a `stock const` variable.

### `SSCANF_VERSION`

The SSCANF include version as BCD, as a `const` to work at compile-time.

### `SSCANF_NO_K_VEHICLE`

Exclude the default `k<vehicle>` kustom specifier from being compiled when this is defined before including the include file.

### `SSCANF_NO_K_WEAPON`

Exclude the default `k<weapon>` kustom specifier from being compiled when this is defined before including the include file.

### `SSCANF_NO_NICE_FEATURES`

Several sscanf features, such as file and line numbers in errors, only work on the new compiler.  If you want to use the old compiler you'll get an error because those nice features won't work.  If you want to compile anyway without those features you need to define this symbol before inclusion.

## `extract`

I've written some (extendable) macros so you can do:

```pawn
extract params -> new a, string:b[32], Float:c; else
{
    return SendClientMessage(playerid, COLOUR_RED, "FAIL!");
}
```

This will compile as:

```pawn
new a, string:b[32], Float:c;
if (unformat(params, "is[32]f", a, b, c))
{
    return SendClientMessage(playerid, COLOUR_RED, "FAIL!");
}
```

Note that `unformat` is the same as `sscanf`, also note that the `SendClientMessage` part is optional:

```pawn
extract params -> new a, string:b[32], Float:c;
```

Will simply compile as:

```pawn
new a, string:b[32], Float:c;
unformat(params, "is[32]f", a, b, c);
```

Basically it just simplifies sscanf a little bit (IMHO).  I like new operators and syntax, hence this, examples:

```pawn
// An int and a float.
extract params -> new a, Float:b;
// An int and an OPTIONAL float.
extract params -> new a, Float:b = 7.0;
// An int and a string.
extract params -> new a, string:s[32];
// An int and a playerid.
extract params -> new a, player:b;
```

As I say, the syntax is extendable, so to add hex numbers you would do:

```pawn
#define hex_EXTRO:%0##%1,%2|||%3=%9|||%4,%5) EXTRY:%0##%1H"("#%9")"#,%2,%3|||%4|||%5)
#define hex_EXTRN:%0##%1,%2|||%3|||%4,%5) EXTRY:%0##%1h,%2,%3|||%4|||%5)
#define hex_EXTRW:%0##%1,%2|||%3[%7]|||%4,%5) EXTRY:%0##%1a<h>[*],%2,(%7),%3|||%4|||%5)
```

That will add the tag `hex` to the system.  Yes, the lines look complicated (because they are), but the ONLY things you need to change are the name before the underscore and the letter near the middle (`H`, `h` and `a<h>` in the examples above for `optional`, `required` and `required array` (no optional arrays yet besides strings)).

New examples (with `hex` added):

```pawn
// A hex number and a player.
extract params -> new hex:a, player:b;
// 32 numbers then 32 players.
extract params -> new a[32], player:b[32];
// 11 floats, an optional string, then an optional hex number.
extract params -> new Float:f[11], string:s[12] = "optional", hex:end = 0xFF;
```

The code is actually surprisingly simple (I developed another new technique to simplify my `tag` macros and it paid off big style here).  By default `Float`, `string`, `player` and `_` (i.e. no tag) are supported, and their individual letter definitions take up the majority of the code as demonstrated with the `hex` addition above.  Note that `string:` is now used extensively in my code to differentiate from tagless arrays in cases like this, it is removed automatically but `player:` and `hex:` are not so you may wish to add:

```pawn
#define player:
#define hex:
```

To avoid tag mismatch warnings (to remove them AFTER the compiler has used them to determine the correct specifier).

The very first example had an `else`, this will turn:

```pawn
unformat(params, "ii", a, b);
```

In to:

```pawn
if (unformat(params, "ii", a, b))
```

You MUST put the `else` on the same line as `extract` for it to be detected, but then you can use normal single or multi-line statements.  This is to cover common command use cases, you can even leave things on the same line:

```pawn
else return SendClientMessage(playerid, 0xFF0000AA, "Usage: /cmd <whatever>");
```

There is now the ability to split by things other than space (i.e. adds `P<?>` to the syntax - updated from using `p` to `P`):

```pawn
extract params<|> -> new a, string:b[32], Float:c;
```

Will simply compile as:

```pawn
new a, string:b[32], Float:c;
unformat(params, "P<|>is[32]f", a, b, c);
```

Note that for technical reasons you can use `<->` (because it looks like the arrow after the `extract` keyword).  You also can't use `<;>`, `<,>`, or `<)>` because of a bug with `#`, but you can use any other character (most notably `<|>`, as is popular with SQL scripts).  I'm thinking of adding enums and existing variables (currently you HAVE to declare new variables), but not right now.

## Similarity

A lot of the code uses a concept of "similarity" when comparing two strings.  This is less accurate, but thus more forgiving, than an exact string comparison.  For example if a player types `nrg` they probably mean the `NRG-500` bike, and if they type `mac10` they probably mean the `Mac 10` gun.  Using standard comparisons these inputs would never match, and using the common "Levenshtein Distance" (as old versions of the code did) can produce some strange results.  For example typing `NRG` as a vehicle input will return `TUG` using Levenshtein, because converting `NRG` to `TUG` only requires three replacements, whereas converting `NRG` to `NRG-500` requires four additions, thus is technically further away despite being more similar to a person.

Thus the new version of sscanf uses a "similarity" metric instead of a "distance" metric to work out which strings are probably the same.  This is used by the `k<vehicle>` and `k<weapon>` pre-defined custom specifiers, and for the `MATCH_NAME_SIMILARITY` option used with `u`, `r`, and `q` (i.e. for names).  The algorithm is roughly based on one of "Bigram Similarity":

* Split the two input strings up in to letter pairs, ignoring punctuation and spaces.  For example `"Shotty"` becomes `"sh", "ho", "ot", "tt", "ty"` and `"Combat Shotgun"` becomes `"co", "om", "mb", "ba", "at", "ts", "sh", "ho", "ot", "tg", "gu", "un"`.

* For each pair of letters from the first word, count how many of them appear in the second word.  For example `"Combat Shotgun"` contains `"sh", "ho", "ot"` from `"Shotty"`, 3/5 (60%) of the available letter pairs.

* Repeat in the reverse, so `"Shotty"` contains `"sh", "ho", "ot"` from `"Combat Shotgun"`, 3/12 (25%) of the available letter pairs (the fact that the two result lists are the same here is pure fluke and irrelevant).

* Invert the fractions to get the percentage of pairs not in the other word, multiply the two numbers, and subtract from `1.0` to give the final result.  So for the example above:

```
similarity = 1 - ((1 - 60%) * (1 - 25%))
similarity = 1 - (0.4 * 0.75)
similarity = 1 - 0.3
similarity = 0.7
```

A similarity is always between `0.0` (totally different) and `1.0` (absolutely identical), and many functions will return the string from a list with the highest similarity.  So `k<vehicle>` will find the vehicle with the best similarity to the given input.  However, this doesn't always make sense.  If the input is `"dkaoiingsjk"`, that is obviously not any sane vehicle, but it still has a similarity rating to every vehicle name; the ratings will be very low, but one must be the highest (it is the `"Sandking"`, with a similarity rating of `0.228571`).  Just calling the similarity functions blindly will thus always return a result, even if that result is gibberish, thus the functions also optionally accept a *threshold*, a similarity value that the result must be better than.  So for the above example passing a threshold of `0.5` would result in no valid vehicle being returned.

## Errors/Warnings

### MSVRC100.dll not found

If you get this error, DO NOT just download the dll from a random website.  This is part of the `Microsoft Visual Studio Redistributable Package`.  This is required for many programs, but they often come with it.  Download it here:

http://www.microsoft.com/download/en...s.aspx?id=5555

### sscanf error: System not initialised

If you get this error, you need to make sure that you have recompiled ALL your scripts using the LATEST version of `sscanf2.inc`.  Older versions didn't really require this as they only had two natives - `sscanf` and `unformat`, the new version has some other functions - you don't need to worry about them, but you must use `sscanf2.inc` so that they are correctly called.  If you think you have done this and STILL get the error then try again - make sure you are using the correct version of PAWNO for example.

### sscanf warning: String buffer overflow.

This error comes up when people try and put too much data in to a string.  For example:

```pawn
new str[10];
sscanf("Hello there, how are you?", "s[10]", str);
```

That code will try and put the string `Hello there, how are you?` in to the variable called `str`.  However, `str` is only 10 cells big and can thus only hold the string `Hello ther` (with a NULL terminator).  In this case, the rest of the data is ignored - which could be good or bad:

```pawn
new str[10], num;
sscanf("Hello there you|42", "p<|>s[10]i", str, num);
```

In this case `num` is still correctly set to `42`, but the warning is given for lost data (`e you`).

Currently there is nothing you can do about this from a programming side (you can't even detect it - that is a problem I intend to address), as long as you specify how much data a user should enter this will simply discard the excess, or make the destination variable large enough to handle all cases.

### sscanf warning: Optional types invalid in array specifiers, consider using 'A'.

A specifier such as:

```
a<I(5)>[10]
```

Has been written - here indicating an array of optional integers all with the default value `5`.  Instead you should use:

```
A<i>(5)[10]
```

This is an optional array of integers all with the default value `5`, the advantage of this is that arrays can have multiple defaults:

```
A<i>(5, 6)[10]
```

That will set the array to `5, 6, 7, 8, 9, 10, 11, 12, 13, 14` by default, incrementing by the found difference each time.

### sscanf warning: Optional types invalid in enum specifiers, consider using 'E'.

Similar to the previous warning, A specifier such as:

```
e<I(5)f>
```

Is invalid, instead use:

```
E<if>(42, 11.0)
```

This forces ALL the parts of an enum to be optional - anything less is not possible.

### sscanf error: Multi-dimensional arrays are not supported.

This is not allowed:

```pawn
sscanf(params, "a<a<i>[5]>[10]", arr);
```

A work-around can be done using:

```pawn
sscanf(params, "a<i>[50]", arr[0]);
```

That will correctly set up the pointers for the system.

### sscanf error: Search strings are not supported in arrays.

This is not allowed (see the section on search strings):

```
a<'hello'i>[10]
```

### sscanf error: Delimiters are not supported in arrays.

This is not allowed:

```
a<p<,>i>[10]
```

Instead use:

```
p<,>a<i>[10]
```

### sscanf error: Quiet sections are not supported in arrays.


This is not allowed:

```
a<{i}>[10]
```

Instead use:

```
{a<i>[10]}
```

### sscanf error: Unknown format specifier '?'.

The given specifier is not known (this post contains a full list of all the specifiers near the bottom).

### sscanf warning: Empty default values.

An optional specifier has been set as (for example):

```
I()
```

Instead of:

```
I(42)
```

This does not apply to strings as they can be legitimately empty.

### sscanf warning: Unclosed default value.

You have a default value on an optional specifier that looks like:

```
I(42
```

Instead of:

```
I(42)
```

### sscanf warning: No default value found.

You have no default value on an optional specifier:

```
I
```

Instead of:

```
I(42)
```

### sscanf warning: Unenclosed specifier parameter.

You are using the old style:

```
p,
```

Instead of:

```
p<,>
```

Alternatively a custom delimiter of:

```
p<
```

Was found with no matching `>` after one character.  Instead use:

```
p<,>
```

Or, if you really do want a delimiter of `<` then use:

```
p<<>
```

Note that this does not need to be escaped; however, a delimiter of `>` does:

```
p<\>>
```

The `\` may also need to be escaped when writing actual PAWN strings, leading to:

```
p<\\>>
```

This also applies to array types (`a<` vs `a<i>`), and will result in an invalid array type.

### sscanf warning: No specified parameter found.

The format specifier just ends with:

```
p
```

This also applies to array types (`a` vs `a<i>`).

### sscanf warning: Missing string length end.
### sscanf warning: Missing length end.

A string has been written as:

```
s[10
```

Instead of:

```
s[10]
```

I.e. the length has not been closed.

### sscanf error: Invalid data length.

An invalid array or string size has been specified (0, negative, or not a number).

### sscanf error: Invalid character in data length.

A string or array has been given a length that is not a number.

### sscanf error: String/array must include a length, please add a destination size.

Arrays are newer than strings, so never had an implementation not requiring a length, so there is no compatibility problems in REQUIRING a length to be given.

### sscanf warning: Can't have nestled quiet sections.

You have tried writing something like this:

```
{i{x}}
```

This has a quiet section (`{}`) inside another one, which makes no sense.

### sscanf warning: Not in a quiet section.

`}` was found with no corresponding `{`:

```
i}
```

### sscanf warning: Can't remove quiet in enum.

This is caused by specifiers such as:

```
{fe<i}x>
```

Where the quiet section is started before the enum, but finishes part way through it rather than after it.  This can be emulated by:

```
{f}e<{i}x>
```

### sscanf error: Arrays are not supported in enums.


Basically, you can't do:

```
e<fa<i>[5]f>
```

You can, however, still do:

```
e<fiiiiif>
```

This is a little more awkward, but is actually more technically correct given how enums are compiled.

### sscanf warning: Unclosed string literal.

A specifier starts a string with `'`, but doesn't close it:

```
i'hello
```

### sscanf warning: sscanf specifiers do not require '%' before them.

`format` uses code such as `%d`, sscanf only needs `d`, and confusingly the C equivalent function (also called `sscanf`) DOES require `%`.  Sorry.

### sscanf error: Insufficient default values.

Default values for arrays can be partially specified and the remainder will be inferred from the pattern of the last two:

```
A<i>(0, 1)[10]
```

That specifier will default to the numbers `0` to `9`.  However, because enums have a mixture of types, all the default values for `E` must ALWAYS be specified:

```
E<iiff>(0, 1, 0.0, 1.0)
```

This will not do:

```
E<iiff>(0, 1)
```

### sscanf error: Options are not supported in enums.

### sscanf error: Options are not supported in arrays.

The `?` specifier for local options must appear outside any other specifier.

### sscanf error: No option value.

An option was specified with no value:

```
?<OLD_DEFAULT_NAME>
```

### sscanf error: Unknown option name.

The given option was not recognised.  Check spelling and case:

```
?<NOT_A_VALID_NAME=1>
```

### sscanf warning: Could not find function SSCANF:?.

A `k` specifier has been used, but the corresponding function could not be found.  If you think it is there check the spelling matches exactly - including the case.

### sscanf error: SSCANF_Init has incorrect parameters.
### sscanf error: SSCANF_Join has incorrect parameters.
### sscanf error: SSCANF_Leave has incorrect parameters.
### sscanf error: SSCANF_IsConnected has incorrect parameters.
### sscanf error: SSCANF_Version has incorrect parameters.
### sscanf error: SSCANF_Option has incorrect parameters.

You edited something in the sscanf2 include - undo it or redownload it.

### sscanf error: SetPlayerName has incorrect parameters.

You somehow managed to call `SetPlayerName` without passing all the parameters.  This can only happen by redefining the native declaration itself, so undo any edits to it.

### sscanf error: Missing required parameters.

`sscanf` itself was called without sufficient parameters.  I.e. the input and specifier strings are missing.  This can also happen when you edit the include itself to mess with the file/line macros.

You somehow managed to call `SetPlayerName` without passing all the parameters.  This can only happen by redefining the native declaration itself, so undo any edits to it.

### `fatal error 111: user error: sscanf already defined, or used before inclusion.`

There are two ways to trigger this:  The first is to have another copy of `sscanf` defined before you include the file.  This used to be the only known way to trigger this error, so the error said:

> `sscanf (possibly the PAWN version) already defined.`

However, there is a second way to trigger it - using `sscanf` before including it.  This used to be possible, but isn't any more as `sscanf` is now a macro that inserts additional data in to the call.  So this will fail:

```pawn
#include <a_samp>

main()
{
	sscanf("hi", "hi");sscanf (possibly the PAWN version) already defined.
}

#include <sscanf2>
```

To fix this, just include `<sscanf2>` before you use `sscanf`.

### `error 004: function "sscanf" is not implemented`
### `error 004: function "sscanf" is not implemented - include <sscanf2> first.`

These are the same error, the only difference being compilers and settings.  Obviously the more useful (second) error which tells you how to solve this problem.  Similar to [the previous error](#fatal-error-111-user-error-sscanf-already-defined-or-used-before-inclusion) this happens when `sscanf` is used before being included, but in a slightly different way:

```pawn
#include <a_samp>

main()
{
	#if defined sscanf
		sscanf("hi", "hi");
	#endif
}

#include <sscanf2>
```

This code tries to be slightly clever, but fails.  The correct way to check for sscanf inclusion is:

```pawn
#if !defined _INC_SSCANF
	#error You need sscanf
#endif
```

There is a third version of this error which looks like:

```
error 004: function "sscanf" is not implemented <library>sscanf</library>      <remarks>  The main entry point.  See the readme for vast amounts of information on how  to call this function and all the details on what it does.  This is a macro  that calls <c>SSCANF__</c> and passes the current file and line number as  well for improved error messages.  </remarks> 
```

For more information on why, see [this compiler issue](https://github.com/pawn-lang/compiler/issues/705).

### sscanf error: Pawn component not loaded.

When loading sscanf as a component on open.mp the Pawn component is also required.  Ensure `pawn.dll` or `pawn.so` is in the `components/` directory.

### sscanf warning: Unknown `player->setName()` return.

The open.mp sscanf component was probably built against an old version of the SDK.  Check for an updated version at https://www.github.com/Y-Less/sscanf/.

### sscanf error: This script was built with the component version of the include.

When compiling a script with the open.mp official includes the sscanf2 include file compiles different code, which assumes that the natives will be loaded as a component.  This error comes when the natives are loaded as a plugin instead, as certain features like `SSCANF_Init` are no longer required in the component case.  Move `sscanf.dll` or `sscanf.so` from the `plugins/` directory to the `components/` directory and remove the legacy plugin name from `plugins` (in server.cfg) or `pawn.legacy_plugins` (in config.json).

## Future Plans

### Reserved Specifiers

The currently used specifiers are:

```
abcdefghiklmnopqrsuxz
```

This leaves only the following specifiers:

```
jtvwy
```

* `t` is for time - some sort of date/time processing that returns a unix timestamp.
* `y` is for "YID" - the YSI user ID.  Don't use YSI?  Tough.
* `v` I figure is for something to do with varargs, similar to `a` but for extra parameters.
* `j` no idea yet.
* `w` is the most important one to reserve - it is for extended specifiers.  Since there are so few left it is important to establish future compatibility.  Thus `w` is a prefix that indicates that the following specifier has an alternate meaning.  So `i` is "integer" but `wi` is something else entirely (don't know what yet).  This scheme does recurse endlessly so `wwi` and `wwwwwi` are also different.  In this way we will never run out and can start adding support for more obscure items like iterators and jagged arrays (the original idea for `j`).  There's also a suggestion for this as `words` - `w<5>` for five words, but I think that makes sense as an extension to `s`.

### Alternates

Alternates are a feature added in sscanf 3 but not yet back-ported.  The symbol is `|` and if one fails to match another one is tried.  The selected branch is returned in the very first destination parameter, the remaining specifiers are all in order:

```pawn
if (sscanf(input, "'clothes'i|'weapon'ii", alternate, clothes, weapon, ammo) == 0)
{
	switch (alternate)
	{
	case 0:
	{
		// Clothes.
		printf("Clothes = %d", clothes);
	}
	case 1:
	{
		// Weapohn.
		printf("Weapon = %d, %d", weapon, ammo);
	}
	}
}
```

Variables can be reused and won't be clobbered:

```pawn
sscanf(input, "?<SSCANF_COLOUR_FORMS=2>m|x", alternate, colour, colour);
if (alternate == 0)
{
	printf("You entered colour #%06x", colour);
}
else
{
	printf("You entered colour %06x", colour);
}
```

Note that the branches must be mutually exclusive in some way.  If they overlap you may never get a later one.  Also variables from branches not taken may be clobbered in any way, so don't rely on their values at all.

### Enums And Arrays

More of these: nested arrays in enums, 2d/3d arrays, strings in enums and arrays, etc.

### Compilation

Basically pre-defining specifier strings for use later:

```pawn
new Specifier:spec = SSCANF_Compile("is[32]");

SSCANF_Run(input, spec, int, string);
```

You could define the base `sscanf` as:

```pawn
sscanf(const input, const specifier, ...)
{
	return SSCANF_Run(input, SSCANF_Compile(specifier), ___(2));
}
```

## Building

If you want to compile sscanf for yourself.

### Getting The Code

You can clone the code using github.  Note that there are multiple submodules involved, so you are best using a recursive checkout:

```
git clone --recursive https://github.com/Y-Less/sscanf/
```

Note the use of the `--recursive` argument, because this repository contains submodules.  A useful setting when cloning recursive repos is:

```bash
git config --global url."git@github.com:".insteadOf "https://github.com/"
```

Which allows you to push `https://` repos you have permissions on.

### Building On Windows

```bash
mkdir build
cd build
cmake .. -A Win32 -T ClangCL
```

Open Visual Studio and build the solution.

### Building On Linux

```bash
mkdir build
cd build
# May need to configure this line.
export CC=/usr/lib/llvm/13/bin/clang CXX=/usr/lib/llvm/13/bin/clang++
cmake ..
make
```

Change `Debug` to `Release` for final versions.

### Building With Docker

```bash
cd docker
.\build.sh
```

You may need to set up some directories first:

```bash
mkdir build
mkdir conan
sudo chown 1000 build
sudo chown 1000 conan
```

Instead you run the script as root, and target a specific distro:

```bash
UBUNTU_VERSION=18.04 sudo .\build.sh
```

The output is in `docker/build/`

## License

### Version: MPL 1.1

The contents of this file are subject to the Mozilla Public License Version
1.1 (the "License"); you may not use this file except in compliance with
the License.  You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied.  See the License
for the specific language governing rights and limitations under the
License.

The Original Code is the sscanf 2.0 SA:MP plugin.

The Initial Developer of the Original Code is Alex "Y_Less" Cole.
Portions created by the Initial Developer are Copyright (c) 2022
the Initial Developer.  All Rights Reserved.

### Contributor(s):

* Cheaterman
* DEntisT
* Emmet_
* karimcambridge
* kalacsparty
* Kirima
* leHeix
* maddinat0r
* Southclaws
* Y_Less
* ziggi

### Special Thanks to:

* SA:MP Team past, present, and future.
* maddinat0r, for hosting the repo for a very long time.
* Emmet_, for his efforts in maintaining it for almost a year.

## Changelog

### sscanf 2.8.2 - 18/04/2015

* Fixed a bug where `u` wasn't working correctly after a server restart.

### sscanf 2.8.3 - 02/10/2018

* Allow `k` in arrays.
* Allow `k` to consume the rest of the line (like strings) when they are the last specifier.

### sscanf 2.9.0 - 04/11/2019

* Added `[*]` support.
* Fixed bracketed lengths (`[(32)]`).
* Ported readme to markdown.
* Added `z` and `Z` for packed strings (thus officially removing their deprecated optional use).
* Remove missing string length warnings - its now purely an error.
* Remove `p,` warnings - its now purely an error.

### sscanf 2.10.0 - 27/06/2020

* Added `m` for colours (ran out of useful letters).
* Added file and line details for errors.

### sscanf 2.10.1 - 27/06/2020

* Plugin backwards compatibility with older includes.

### sscanf 2.10.2 - 28/06/2020

* Fix bug in parameter counts.

### sscanf 2.11.2 - 28/04/2021

* Use prehooks in include.
* Export `PawnSScanf` function from dll to other plugins.
* `SSCANF_SetOption()` and `SSCANF_GetOption()` for more control of options.
* `SSCANF_VERSION` and `SSCANF_Version()` to compare include and plugin versions.
* Hide more internal functions.
* Fix the license.

### sscanf 2.10.4 - 17/01/2022

* Fix trailing string literals, to allow `"x'!'"` for example.
* Added `SSCANF_VERSION` for compile-time checks.

### sscanf 2.11.1 - 25/01/2022

* Re-added NPC mode support.

### sscanf 2.11.2 - 04/02/2022

* Minor Linux build fixes.

### sscanf 2.11.3 - 05/02/2022

* Added `SSCANF_Levenshtein` for better string candidate processing.
* Added `SSCANF_GetClosestString` for better string candidate processing.
* Added `SSCANF_GetClosestValue` for better string candidate processing.
* Added `SSCANF_NO_K_VEHICLE` to disable the default `k<vehicle>` specifier code.
* Added `SSCANF_NO_K_WEAPON` to disable the default `k<weapon>` specifier code.

### sscanf 2.11.4 - 02/03/2022

* Documentation comments on all functions via pawndoc.

### sscanf 2.11.5 - 31/03/2022

* Improve some errors caused by using `sscanf` before including it.

### sscanf 2.12.1 - 05/05/2022

* Integrate open.mp component support.

### sscanf 2.12.2 - 11/05/2022

* Switch to a different (semi made-up) word similarity function.
* Added `SSCANF_TextSimilarity` for best string candidate processing.
* Added `SSCANF_GetSimilarString` for best string candidate processing.
* Added `SSCANF_GetSimilarValue` for best string candidate processing.
* Use `OnPlayerNameChange` in the open.mp component code version.
* Switch `SSCANF_Levenshtein` internally to use direct AMX access.

### sscanf 2.13.1 - 25/06/2022

* Enable similarity-based name comparisons (`MATCH_NAME_SIMILARITY`).
* Return the best matching name by default.
* Add `MATCH_NAME_FIRST` to revert best name match behaviour.
* Improve `MATCH_NAME_PARTIAL`.
* Internal cleanup and fixes.

### sscanf 2.13.2 - 07/09/2022

* Rebuild for open.mp beta 9 SDK changes.

### sscanf 2.13.3 - 04/12/2022

* Add `@kustom()` decorator for kustom specifiers.
* Use *subhook* to hook `amx_Register` and find `SetPlayerName`.

### sscanf 2.13.4 - 20/12/2022

* Update open.mp SDK.
* Added `(*)` for dynamic default values.

### sscanf 2.13.5 - 28/12/2022

* Move builds to CMake.
* Add docker builds.
* Fix `[*]` again.

### sscanf 2.13.6 - 28/12/2022

* Fixed a crash with `[*]` when there aren't enough parameters.

### sscanf 2.13.7 - 02/01/2023

* Improve GDK plugin compatibility.

### sscanf 2.13.8 - 05/01/2023

* "Final" SDK update.


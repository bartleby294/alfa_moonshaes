/****************************************************
  Persistent Token Constants Script
  apts_const_ptok

  Last Updated: September 22, 2002

  ***Ambrosia Persistent Token System***
    Created by Mojo(Allen Sun)

  This script contains common internal constants used
  by other scripts.  It is not adviseable to
  modify these constants unless you know what you are
  doing.

****************************************************/
float APTS_VERSION = 1.0;

int MAX_INT = 2147483647;

int APTS_LARGE_INT  = 3;
int APTS_MEDIUM_INT = 2;
int APTS_SMALL_INT  = 1;

int APTS_TYPE_INT   = 1;
int APTS_TYPE_BOOL  = 2;
int APTS_TYPE_FLOAT = 3;
int APTS_TYPE_STRING = 4;
int APTS_TYPE_LOCATION = 5;

int CINT_TOKENS_FOR_BASE    = 11;
int CINT_BITS_PER_TOKEN     = 11;
int CINT_NUMBER_BASE        = 2048;

int CINT_MAX_UNSIGNED_ONE = 2047;
int CINT_MAX_UNSIGNED_TWO = 4194303;
int CINT_MAX_UNSIGNED_THREE = MAX_INT;

int CINT_MAX_SIGNED_ONE = 1023;
int CINT_MAX_SIGNED_TWO = 2097151;
int CINT_MAX_SIGNED_THREE = MAX_INT;

int CINT_MAX_SLOTS  =  105;

int CINT_PRIME_HASH = 4194301;
// Persistent Token Box Tag
string APTS_TOKEN_BOX_TAG             = "APTS_TOKBOX_NODD";
// Persistent Token Base Tag
string APTS_TOKEN_TAG                 = "APTS_NOD";

string APTS_CHAR_TABLE = " ! #$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~";


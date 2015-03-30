//
//                           Speech Front End
//                                 (sfe)
//
//  Module:  sfe.common
//  Purpose: Common operations.
//  Author:  Fabian Jakobs
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or (at
// your option) any later version.
// 
// This program is distributed in the hope that it will be useful, but
// WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


#ifdef HAVE_CONFIG_H
#include <btk.h>
#endif

#include <iostream>

#ifdef HAVE_EXECINFO_H 
#include <execinfo.h>
#endif

#include "jexception.h"

using namespace std;

j_error::j_error(const char* what_arg, ...) throw() { 
  BUILDMSG(what_arg);
  code = JERROR;
  //cout << _what << endl;
}

j_error::~j_error() throw() { 
  //cout << _what << endl;
  //print_trace();
}

/* prints a stacktrace */
void j_error::print_trace (void)
{
#ifdef HAVE_EXECINFO_H
  void *array[20];
  size_t size;
  char **strings;
  size_t i;

  size = backtrace (array, 20);
  strings = backtrace_symbols (array, size);

  printf ("Obtained %zd stack frames.\n", size);

  for (i = 0; i < size; i++)
     printf ("%s\n", strings[i]);

  free (strings);
#else
  printf("no execinfo on this system availible!\n");
#endif
}

/* builds a message from variable arguments
 * Note: Caller nedds to call va_start on ap! */
const char* j_error::make_msg(const char* what_arg, va_list& ap) {
  int n, size = 100;
  char *p;
  if ((p = (char*)malloc(size)) == NULL) {
    return NULL;
  }
  while(1) {
    /* Try to print in the allocated space. */
    /* this needs to be calles by the caller! */
    // va_start(ap, what_arg);
    n = vsnprintf(p, size, what_arg, ap);
    va_end(ap);
    /* If that worked, return the string. */
    if (n > -1 && n < size) {
      return p;
    }
    /* Else try again with more space. */
    if (n > -1)   /* glibc 2.1 */
      size = n+1; /* precisely what is needed */
    else          /* glibc 2.0 */
      size *= 2;  /* trwice the old size */
    if ((p = (char*)realloc (p, size)) == NULL) {
      return NULL;
    }
  }
};

jiterator_error::jiterator_error(const char* what_arg, ...) { 
  BUILDMSG(what_arg); 
  code = JITERATOR;
}

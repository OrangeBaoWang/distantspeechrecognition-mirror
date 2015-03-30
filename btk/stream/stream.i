//                              -*- C++ -*-
//
//                           Speech Front End
//                                 (sfe)
//
//  Module:  btk.stream
//  Purpose: Representation of feature streams.
//  Author:  John McDonough
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


%module(package="btk") stream

%{
#include "stream/stream.h"
#include "stream/pyStream.h"
#include "stream/fileStream.h"
%}

typedef int size_t;

%include gsl/gsl_types.h
%include jexception.i
%include complex.i
%include matrix.i
%include vector.i
%include typedefs.i

// ----- definition for class `VectorCharFeatureStream' -----
// 
%ignore VectorCharFeatureStream;
class VectorCharFeatureStream {
 public:
  ~VectorCharFeatureStream();

  const String& name() const;
  virtual unsigned size() const;

  virtual const gsl_vector_char* next(int frameX = -5) const;
  virtual void reset();
};

class VectorCharFeatureStreamPtr {
 public:
  %extend {
    VectorCharFeatureStreamPtr __iter__() {
      (*self)->reset();  return *self;
    }
  }

  VectorCharFeatureStream* operator->();
};


// ----- definition for class `VectorShortFeatureStream' -----
// 
%ignore VectorShortFeatureStream;
class VectorShortFeatureStream {
 public:
  ~VectorShortFeatureStream();

  const String& name() const;
  virtual unsigned size() const;

  virtual const gsl_vector_short* next(int frameX = -5) const;
  virtual void reset();
};

class VectorShortFeatureStreamPtr {
 public:
  %extend {
    VectorShortFeatureStreamPtr __iter__() {
      (*self)->reset();  return *self;
    }
  }

  VectorShortFeatureStream* operator->();
};


// ----- definition for class `VectorFloatFeatureStream' -----
// 
%ignore VectorFloatFeatureStream;
class VectorFloatFeatureStream {
 public:
  ~VectorFloatFeatureStream();

  const String& name() const;
  virtual unsigned size() const;
  bool isEnd();
  virtual const gsl_vector_float* next(int frameX = -5);
  const gsl_vector_float* current();  
  virtual void reset();
};

class VectorFloatFeatureStreamPtr {
 public:
  %extend {
    VectorFloatFeatureStreamPtr __iter__() {
      (*self)->reset();  return *self;
    }
  }

  VectorFloatFeatureStream* operator->();
};


// ----- definition for class `VectorFeatureStream' -----
// 
%ignore VectorFeatureStream;
class VectorFeatureStream {
 public:
  ~VectorFeatureStream();

  const String& name() const;
  virtual unsigned size() const;

  virtual const gsl_vector* next(int frameX = -5);
  const gsl_vector* current();
  virtual void reset();
};

class VectorFeatureStreamPtr {
 public:
  %extend {
    VectorFeatureStreamPtr __iter__() {
      (*self)->reset();  return *self;
    }
  }

  VectorFeatureStream* operator->();
};


// ----- definition for class `VectorComplexFeatureStream' -----
// 
%ignore VectorComplexFeatureStream;
class VectorComplexFeatureStream {
 public:
  ~VectorComplexFeatureStream();

  const String& name() const;
  virtual unsigned size() const;

  virtual const gsl_vector_complex* next(int frameX = -5);
  const gsl_vector_complex* current();
  virtual void reset();
};

class VectorComplexFeatureStreamPtr {
 public:
  %extend {
    VectorComplexFeatureStreamPtr __iter__() {
      (*self)->reset();  return *self;
    }
  }

  VectorComplexFeatureStream* operator->();
};


// // ----- definition for class `PyVectorCharFeatureStream' -----
// // 
// %ignore PyVectorCharFeatureStream;
// class PyVectorCharFeatureStream : public VectorCharFeatureStream {
//  public:
//   PyVectorCharFeatureStream(PyObject* c, const String& nm);
//   ~PyVectorCharFeatureStream();
// };

// class PyVectorCharFeatureStreamPtr : public VectorCharFeatureStreamPtr {
//  public:
//   %extend {
//     PyVectorCharFeatureStreamPtr(PyObject* c, const String& nm = "PyVector") {
//       return new PyVectorCharFeatureStreamPtr(new PyVectorCharFeatureStream(c, nm));
//     }
//   }

//   PyVectorCharFeatureStream* operator->();
// };


// ----- definition for class `PyVectorShortFeatureStream' -----
// 
%ignore PyVectorShortFeatureStream;
class PyVectorShortFeatureStream : public VectorShortFeatureStream {
 public:
  PyVectorShortFeatureStream(PyObject* c, const String& nm);
  ~PyVectorShortFeatureStream();
};

class PyVectorShortFeatureStreamPtr : public VectorShortFeatureStreamPtr {
 public:
  %extend {
    PyVectorShortFeatureStreamPtr(PyObject* c, const String& nm = "PyVector") {
      return new PyVectorShortFeatureStreamPtr(new PyVectorShortFeatureStream(c, nm));
    }
  }

  PyVectorShortFeatureStream* operator->();
};


// ----- definition for class `PyVectorFloatFeatureStream' -----
// 
%ignore PyVectorFloatFeatureStream;
class PyVectorFloatFeatureStream : public VectorFloatFeatureStream {
 public:
  PyVectorFloatFeatureStream(PyObject* c, const String& nm);
  ~PyVectorFloatFeatureStream();
};

class PyVectorFloatFeatureStreamPtr : public VectorFloatFeatureStreamPtr {
 public:
  %extend {
    PyVectorFloatFeatureStreamPtr(PyObject* c, const String& nm = "PyVector") {
      return new PyVectorFloatFeatureStreamPtr(new PyVectorFloatFeatureStream(c, nm));
    }
  }

  PyVectorFloatFeatureStream* operator->();
};


// ----- definition for class `PyVectorFeatureStream' -----
// 
%ignore PyVectorFeatureStream;
class PyVectorFeatureStream : public VectorFeatureStream {
 public:
  PyVectorFeatureStream(PyObject* c, const String& nm);
  ~PyVectorFeatureStream();
};

class PyVectorFeatureStreamPtr : public VectorFeatureStreamPtr {
 public:
  %extend {
    PyVectorFeatureStreamPtr(PyObject* c, const String& nm = "PyVector") {
      return new PyVectorFeatureStreamPtr(new PyVectorFeatureStream(c, nm));
    }
  }

  PyVectorFeatureStream* operator->();
};


// ----- definition for class `PyVectorComplexFeatureStream' -----
// 
%ignore PyVectorComplexFeatureStream;
class PyVectorComplexFeatureStream : public VectorComplexFeatureStream {
 public:
  PyVectorComplexFeatureStream(PyObject* c, const String& nm = "PyVectorComplex");
  ~PyVectorComplexFeatureStream();
};

class PyVectorComplexFeatureStreamPtr : public VectorComplexFeatureStreamPtr {
 public:
  %extend {
    PyVectorComplexFeatureStreamPtr(PyObject* c, const String& nm = "PyVectorComplex") {
      return new PyVectorComplexFeatureStreamPtr(new PyVectorComplexFeatureStream(c, nm));
    }
  }

  PyVectorComplexFeatureStream* operator->();
};

// ----- definition for class `FileHandler' -----
// 
%ignore FileHandler;
class FileHandler {
 public:

  FileHandler( const String &filename, const String &mode );
  ~FileHandler();
  int readInt();
  String readString( );
  void writeInt( int val );
  void writeString( String val );
};

class FileHandlerPtr {
 public:
  %extend {
    FileHandlerPtr( const String &filename, const String &mode ){
      return new FileHandlerPtr(new FileHandler( filename, mode ) );
    }
  }

  FileHandler* operator->();
};

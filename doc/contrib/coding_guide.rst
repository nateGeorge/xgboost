################
Coding Guideline
################

**Contents**

.. contents::
  :backlinks: none
  :local:

********************
C++ Coding Guideline
********************
- Follow `Google style for C++ <https://google.github.io/styleguide/cppguide.html>`_, with two exceptions:

  * Each line of text may contain up to 100 characters.
  * The use of C++ exceptions is allowed.

- Use C++11 features such as smart pointers, braced initializers, lambda functions, and ``std::thread``.
- Use Doxygen to document all the interface code.
- We have a series of automatic checks to ensure that all of our codebase complies with the Google style. Before submitting your pull request, you are encouraged to run the style checks on your machine. See :ref:`running_checks_locally`.

***********************
Python Coding Guideline
***********************
- Follow `PEP 8: Style Guide for Python Code <https://www.python.org/dev/peps/pep-0008/>`_. We use PyLint to automatically enforce PEP 8 style across our Python codebase. Before submitting your pull request, you are encouraged to run PyLint on your machine. See :ref:`running_checks_locally`.
- Docstrings should be in `NumPy docstring format <https://numpydoc.readthedocs.io/en/latest/format.html>`_.

.. _running_checks_locally:

*********************************
Running Formatting Checks Locally
*********************************

Once you submit a pull request to `dmlc/xgboost <https://github.com/dmlc/xgboost>`_, we perform
two automatic checks to enforce coding style conventions. To expedite the code review process, you are encouraged to run the checks locally on your machine prior to submitting your pull request.

Linter
======
We use `pylint <https://github.com/PyCQA/pylint>`_ and `cpplint <https://github.com/cpplint/cpplint>`_ to enforce style convention and find potential errors. Linting is especially useful for Python, as we can catch many errors that would have otherwise occured at run-time.

To run this check locally, run the following command from the top level source tree:

.. code-block:: bash

  cd /path/to/xgboost/
  make lint

This command requires the Python packages pylint and cpplint.

Clang-tidy
==========
`Clang-tidy <https://clang.llvm.org/extra/clang-tidy/>`_ is an advance linter for C++ code, made by the LLVM team. We use it to conform our C++ codebase to modern C++ practices and conventions.

To run this check locally, run the following command from the top level source tree:

.. code-block:: bash

  cd /path/to/xgboost/
  python3 tests/ci_build/tidy.py

Also, the script accepts two optional integer arguments, namely ``--cpp`` and ``--cuda``. By default they are both set to 1, meaning that both C++ and CUDA code will be checked. If the CUDA toolkit is not installed on your machine, you'll encounter an error. To exclude CUDA source from linting, use:

.. code-block:: bash

  cd /path/to/xgboost/
  python3 tests/ci_build/tidy.py --cuda=0

Similarly, if you want to exclude C++ source from linting:

.. code-block:: bash

  cd /path/to/xgboost/
  python3 tests/ci_build/tidy.py --cpp=0


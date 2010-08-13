#!/usr/bin/python
"""

:date: (>>>DATE<<<) 
:author: (>>>USER_NAME<<<)

"""
from __future__ import print_function
__docformat__ = "restructuredtext en"


if __name__ == "__main__" :

    import sys
    import doctest

    def run_doctest():
        """
        Run doctest on this module.

        >>> 1
        1
        """
        doctest.testmod()

    def my_test():
        pass

    if len(sys.argv) == 2 and sys.argv[1] == "--doctest" : 
        run_doctest()
    else :
        my_test()

#def doctest_func() :
#    """
#    """
#    pass
#
#import tests.docmod
#
#if tests.docmod.doctest == __name__:  
#    import pprint
#    import sys
#    import tests.doctest_utils
#    from   locator import Locator
#
#def stub_main( args ) : 
#    print "stub_main:", args
#
#
#if __name__ == "__main__" :
#
#    import pprint
#    import sys
#
#    def doctest():
#        """
#        Run doctest on this module.
#
#        >>> 1
#        1
#        """
#        
#        import doctest
#        doctest.testmod()
#
#    def my_test() :
#        """
#        Run local tests.
#        """
#        print "test code ..."
#        
#    if len(sys.argv) == 2 and sys.argv[1] == "--doctest" : 
#        doctest()
#    else :
#        my_test()

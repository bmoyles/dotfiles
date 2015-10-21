class HasZpython(object):
    _has_zpython = None

    def __call__(self, pl, *args, **kwargs):
        if self._has_zpython is None:
            try:
                import zsh
            except ImportError as e:
                self._has_zpython = False
            else:
                self._has_zpython = True
        return self._has_zpython

has_zpython = HasZpython()

def show_vcs(pl, segment_info, *args, **kwargs):
    return (segment_info['environ'].get('POWERLINE_NO_VCS', None) is not None)

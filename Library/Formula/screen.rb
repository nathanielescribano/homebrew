require 'formula'

class Screen <Formula
  homepage 'http://www.gnu.org/software/screen/'
  url 'http://ftp.gnu.org/gnu/screen/screen-4.0.3.tar.gz'
  md5 '8506fd205028a96c741e4037de6e3c42'

  # brew install --HEAD to get the latests, includes vertical split, mapped
  # to C-a |
  head 'git://git.savannah.gnu.org/screen.git', :branch => 'master'

  def patches
    unless ARGV.build_head?
      # fixes stropts.h compile error (patch from MacPorts:
      # https://trac.macports.org/ticket/13009), not necessary with --HEAD
      { :p0 => "https://trac.macports.org/raw-attachment/ticket/13009/patch-pty.c" }
    end
  end

  def install
    if ARGV.build_head?
      ENV['CC'] = "gcc"
      cd 'src'
      system "autoheader"
      system "autoconf"
    end
    system "./configure", "--enable-colors256", "--mandir=#{man}", "--infodir=#{info}", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end

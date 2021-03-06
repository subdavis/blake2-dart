// Written in 2013 by Dmitry Chestnykh.
//
// To the extent possible under law, the author have dedicated all copyright
// and related and neighboring rights to this software to the public domain
// worldwide. This software is distributed without any warranty.
// http://creativecommons.org/publicdomain/zero/1.0/

part of blake2;

// Configuration for tree mode.
class HashTreeConfig {
  int _fanout;
  int _maxDepth;
  int _leafSize;
  int _nodeOffset;
  int _nodeDepth;
  int _innerHashSize;

  int _maxNodeOffset;
  int _maxInnerHashSize;

  bool isLastNode;

  int get fanout => _fanout;
  int get maxDepth => _maxDepth;
  int get leafSize => _leafSize;
  int get nodeOffset => _nodeOffset;
  int get nodeDepth => _nodeDepth;
  int get innerHashSize => _innerHashSize;

  // Returns an instance of tree configuration for BLAKE2s.
  HashTreeConfig.BLAKE2s() {
    _maxNodeOffset = 281474976710655; // 2^48-1
    _maxInnerHashSize = 32;
  }

  // Returns an instance of tree configuration for BLAKE2b.
  HashTreeConfig.BLAKE2b() {
    // Do not limit nodeOffset (which must be limited
    // to 2^64-1) for JavaScript compatibility.
    _maxNodeOffset = -1;
    _maxInnerHashSize = 64;
  }

  set fanout(int n) {
    if (n < 0 || n == 1 || n > 255) {
      throw new ArgumentError('Incorrect fanout');
    }
    _fanout = n;
  }

  set maxDepth(int n) {
    if (n < 2 || n > 255) {
      throw new ArgumentError('Incorrect maxDepth');
    }
    _maxDepth = n;
  }

  set leafSize(int n) {
    if (n < 0 || n > 0xffffffff) {
      throw new ArgumentError('Incorrect leafSize');
    }
    _leafSize = n;
  }

  set nodeOffset(int n) {
    if (n < 0 || (_maxNodeOffset > 0 && n > _maxNodeOffset)) {
      throw new ArgumentError('Incorrect nodeOffset');
    }
    _nodeOffset = n;
  }

  set nodeDepth(int n) {
    if (n < 0 || n > 255) {
      throw new ArgumentError('Incorrect nodeDepth');
    }
    _nodeDepth = n;
  }

  set innerHashSize(int n) {
    if (n < 1 || n > _maxInnerHashSize) {
      throw new ArgumentError('Incorrect innerHashSize');
    }
    _innerHashSize = n;
  }
}


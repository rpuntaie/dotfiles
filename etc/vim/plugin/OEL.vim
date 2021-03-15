py3 << EOF
try:
  import vim
  from pynput.keyboard import Key, Listener
  vim.vars['oelisspacepressed'] = -1
  def oel_on_press_space(key):
      if key == Key.space and vim.vars['oelisspacepressed'] == 0:
          vim.vars['oelisspacepressed'] = 1
  def oel_on_release_space(key):
      if key == Key.space:
          vim.vars['oelisspacepressed'] = 0
  oel_listen_space = Listener(
      on_press=oel_on_press_space,
      on_release=oel_on_release_space)
except Exception as e:
  pass #print("OEL plugin: ", e)
EOF

if exists("g:oelisspacepressed")

  function! s:OelReplace(lhs, rhs) abort
    return g:oelisspacepressed==1 ? a:rhs : a:lhs
  endfunction

  function! s:Oelon()
    if g:oelisspacepressed==-1
      inoremap <silent><expr> vv <SID>OelReplace('vv', nr2char(0xf700))
      inoremap <silent><expr> vc <SID>OelReplace('vc', nr2char(0xf701))
      inoremap <silent><expr> vx <SID>OelReplace('vx', nr2char(0xf702))
      inoremap <silent><expr> vz <SID>OelReplace('vz', nr2char(0xf703))
      inoremap <silent><expr> vf <SID>OelReplace('vf', nr2char(0xf704))
      inoremap <silent><expr> vd <SID>OelReplace('vd', nr2char(0xf705))
      inoremap <silent><expr> vs <SID>OelReplace('vs', nr2char(0xf706))
      inoremap <silent><expr> va <SID>OelReplace('va', nr2char(0xf707))
      inoremap <silent><expr> vr <SID>OelReplace('vr', nr2char(0xf708))
      inoremap <silent><expr> ve <SID>OelReplace('ve', nr2char(0xf709))
      inoremap <silent><expr> vw <SID>OelReplace('vw', nr2char(0xf70a))
      inoremap <silent><expr> vq <SID>OelReplace('vq', nr2char(0xf70b))
      inoremap <silent><expr> v4 <SID>OelReplace('v4', nr2char(0xf70c))
      inoremap <silent><expr> v3 <SID>OelReplace('v3', nr2char(0xf70d))
      inoremap <silent><expr> v2 <SID>OelReplace('v2', nr2char(0xf70e))
      inoremap <silent><expr> v1 <SID>OelReplace('v1', nr2char(0xf70f))
      inoremap <silent><expr> cv <SID>OelReplace('cv', nr2char(0xf710))
      inoremap <silent><expr> cc <SID>OelReplace('cc', nr2char(0xf711))
      inoremap <silent><expr> cx <SID>OelReplace('cx', nr2char(0xf712))
      inoremap <silent><expr> cz <SID>OelReplace('cz', nr2char(0xf713))
      inoremap <silent><expr> cf <SID>OelReplace('cf', nr2char(0xf714))
      inoremap <silent><expr> cd <SID>OelReplace('cd', nr2char(0xf715))
      inoremap <silent><expr> cs <SID>OelReplace('cs', nr2char(0xf716))
      inoremap <silent><expr> ca <SID>OelReplace('ca', nr2char(0xf717))
      inoremap <silent><expr> cr <SID>OelReplace('cr', nr2char(0xf718))
      inoremap <silent><expr> ce <SID>OelReplace('ce', nr2char(0xf719))
      inoremap <silent><expr> cw <SID>OelReplace('cw', nr2char(0xf71a))
      inoremap <silent><expr> cq <SID>OelReplace('cq', nr2char(0xf71b))
      inoremap <silent><expr> c4 <SID>OelReplace('c4', nr2char(0xf71c))
      inoremap <silent><expr> c3 <SID>OelReplace('c3', nr2char(0xf71d))
      inoremap <silent><expr> c2 <SID>OelReplace('c2', nr2char(0xf71e))
      inoremap <silent><expr> c1 <SID>OelReplace('c1', nr2char(0xf71f))
      inoremap <silent><expr> xv <SID>OelReplace('xv', nr2char(0xf720))
      inoremap <silent><expr> xc <SID>OelReplace('xc', nr2char(0xf721))
      inoremap <silent><expr> xx <SID>OelReplace('xx', nr2char(0xf722))
      inoremap <silent><expr> xz <SID>OelReplace('xz', nr2char(0xf723))
      inoremap <silent><expr> xf <SID>OelReplace('xf', nr2char(0xf724))
      inoremap <silent><expr> xd <SID>OelReplace('xd', nr2char(0xf725))
      inoremap <silent><expr> xs <SID>OelReplace('xs', nr2char(0xf726))
      inoremap <silent><expr> xa <SID>OelReplace('xa', nr2char(0xf727))
      inoremap <silent><expr> xr <SID>OelReplace('xr', nr2char(0xf728))
      inoremap <silent><expr> xe <SID>OelReplace('xe', nr2char(0xf729))
      inoremap <silent><expr> xw <SID>OelReplace('xw', nr2char(0xf72a))
      inoremap <silent><expr> xq <SID>OelReplace('xq', nr2char(0xf72b))
      inoremap <silent><expr> x4 <SID>OelReplace('x4', nr2char(0xf72c))
      inoremap <silent><expr> x3 <SID>OelReplace('x3', nr2char(0xf72d))
      inoremap <silent><expr> x2 <SID>OelReplace('x2', nr2char(0xf72e))
      inoremap <silent><expr> x1 <SID>OelReplace('x1', nr2char(0xf72f))
      inoremap <silent><expr> zv <SID>OelReplace('zv', nr2char(0xf730))
      inoremap <silent><expr> zc <SID>OelReplace('zc', nr2char(0xf731))
      inoremap <silent><expr> zx <SID>OelReplace('zx', nr2char(0xf732))
      inoremap <silent><expr> zz <SID>OelReplace('zz', nr2char(0xf733))
      inoremap <silent><expr> zf <SID>OelReplace('zf', nr2char(0xf734))
      inoremap <silent><expr> zd <SID>OelReplace('zd', nr2char(0xf735))
      inoremap <silent><expr> zs <SID>OelReplace('zs', nr2char(0xf736))
      inoremap <silent><expr> za <SID>OelReplace('za', nr2char(0xf737))
      inoremap <silent><expr> zr <SID>OelReplace('zr', nr2char(0xf738))
      inoremap <silent><expr> ze <SID>OelReplace('ze', nr2char(0xf739))
      inoremap <silent><expr> zw <SID>OelReplace('zw', nr2char(0xf73a))
      inoremap <silent><expr> zq <SID>OelReplace('zq', nr2char(0xf73b))
      inoremap <silent><expr> z4 <SID>OelReplace('z4', nr2char(0xf73c))
      inoremap <silent><expr> z3 <SID>OelReplace('z3', nr2char(0xf73d))
      inoremap <silent><expr> z2 <SID>OelReplace('z2', nr2char(0xf73e))
      inoremap <silent><expr> z1 <SID>OelReplace('z1', nr2char(0xf73f))
      inoremap <silent><expr> fv <SID>OelReplace('fv', nr2char(0xf740))
      inoremap <silent><expr> fc <SID>OelReplace('fc', nr2char(0xf741))
      inoremap <silent><expr> fx <SID>OelReplace('fx', nr2char(0xf742))
      inoremap <silent><expr> fz <SID>OelReplace('fz', nr2char(0xf743))
      inoremap <silent><expr> ff <SID>OelReplace('ff', nr2char(0xf744))
      inoremap <silent><expr> fd <SID>OelReplace('fd', nr2char(0xf745))
      inoremap <silent><expr> fs <SID>OelReplace('fs', nr2char(0xf746))
      inoremap <silent><expr> fa <SID>OelReplace('fa', nr2char(0xf747))
      inoremap <silent><expr> fr <SID>OelReplace('fr', nr2char(0xf748))
      inoremap <silent><expr> fe <SID>OelReplace('fe', nr2char(0xf749))
      inoremap <silent><expr> fw <SID>OelReplace('fw', nr2char(0xf74a))
      inoremap <silent><expr> fq <SID>OelReplace('fq', nr2char(0xf74b))
      inoremap <silent><expr> f4 <SID>OelReplace('f4', nr2char(0xf74c))
      inoremap <silent><expr> f3 <SID>OelReplace('f3', nr2char(0xf74d))
      inoremap <silent><expr> f2 <SID>OelReplace('f2', nr2char(0xf74e))
      inoremap <silent><expr> f1 <SID>OelReplace('f1', nr2char(0xf74f))
      inoremap <silent><expr> dv <SID>OelReplace('dv', nr2char(0xf750))
      inoremap <silent><expr> dc <SID>OelReplace('dc', nr2char(0xf751))
      inoremap <silent><expr> dx <SID>OelReplace('dx', nr2char(0xf752))
      inoremap <silent><expr> dz <SID>OelReplace('dz', nr2char(0xf753))
      inoremap <silent><expr> df <SID>OelReplace('df', nr2char(0xf754))
      inoremap <silent><expr> dd <SID>OelReplace('dd', nr2char(0xf755))
      inoremap <silent><expr> ds <SID>OelReplace('ds', nr2char(0xf756))
      inoremap <silent><expr> da <SID>OelReplace('da', nr2char(0xf757))
      inoremap <silent><expr> dr <SID>OelReplace('dr', nr2char(0xf758))
      inoremap <silent><expr> de <SID>OelReplace('de', nr2char(0xf759))
      inoremap <silent><expr> dw <SID>OelReplace('dw', nr2char(0xf75a))
      inoremap <silent><expr> dq <SID>OelReplace('dq', nr2char(0xf75b))
      inoremap <silent><expr> d4 <SID>OelReplace('d4', nr2char(0xf75c))
      inoremap <silent><expr> d3 <SID>OelReplace('d3', nr2char(0xf75d))
      inoremap <silent><expr> d2 <SID>OelReplace('d2', nr2char(0xf75e))
      inoremap <silent><expr> d1 <SID>OelReplace('d1', nr2char(0xf75f))
      inoremap <silent><expr> sv <SID>OelReplace('sv', nr2char(0xf760))
      inoremap <silent><expr> sc <SID>OelReplace('sc', nr2char(0xf761))
      inoremap <silent><expr> sx <SID>OelReplace('sx', nr2char(0xf762))
      inoremap <silent><expr> sz <SID>OelReplace('sz', nr2char(0xf763))
      inoremap <silent><expr> sf <SID>OelReplace('sf', nr2char(0xf764))
      inoremap <silent><expr> sd <SID>OelReplace('sd', nr2char(0xf765))
      inoremap <silent><expr> ss <SID>OelReplace('ss', nr2char(0xf766))
      inoremap <silent><expr> sa <SID>OelReplace('sa', nr2char(0xf767))
      inoremap <silent><expr> sr <SID>OelReplace('sr', nr2char(0xf768))
      inoremap <silent><expr> se <SID>OelReplace('se', nr2char(0xf769))
      inoremap <silent><expr> sw <SID>OelReplace('sw', nr2char(0xf76a))
      inoremap <silent><expr> sq <SID>OelReplace('sq', nr2char(0xf76b))
      inoremap <silent><expr> s4 <SID>OelReplace('s4', nr2char(0xf76c))
      inoremap <silent><expr> s3 <SID>OelReplace('s3', nr2char(0xf76d))
      inoremap <silent><expr> s2 <SID>OelReplace('s2', nr2char(0xf76e))
      inoremap <silent><expr> s1 <SID>OelReplace('s1', nr2char(0xf76f))
      inoremap <silent><expr> av <SID>OelReplace('av', nr2char(0xf770))
      inoremap <silent><expr> ac <SID>OelReplace('ac', nr2char(0xf771))
      inoremap <silent><expr> ax <SID>OelReplace('ax', nr2char(0xf772))
      inoremap <silent><expr> az <SID>OelReplace('az', nr2char(0xf773))
      inoremap <silent><expr> af <SID>OelReplace('af', nr2char(0xf774))
      inoremap <silent><expr> ad <SID>OelReplace('ad', nr2char(0xf775))
      inoremap <silent><expr> as <SID>OelReplace('as', nr2char(0xf776))
      inoremap <silent><expr> aa <SID>OelReplace('aa', nr2char(0xf777))
      inoremap <silent><expr> ar <SID>OelReplace('ar', nr2char(0xf778))
      inoremap <silent><expr> ae <SID>OelReplace('ae', nr2char(0xf779))
      inoremap <silent><expr> aw <SID>OelReplace('aw', nr2char(0xf77a))
      inoremap <silent><expr> aq <SID>OelReplace('aq', nr2char(0xf77b))
      inoremap <silent><expr> a4 <SID>OelReplace('a4', nr2char(0xf77c))
      inoremap <silent><expr> a3 <SID>OelReplace('a3', nr2char(0xf77d))
      inoremap <silent><expr> a2 <SID>OelReplace('a2', nr2char(0xf77e))
      inoremap <silent><expr> a1 <SID>OelReplace('a1', nr2char(0xf77f))
      inoremap <silent><expr> rv <SID>OelReplace('rv', nr2char(0xf780))
      inoremap <silent><expr> rc <SID>OelReplace('rc', nr2char(0xf781))
      inoremap <silent><expr> rx <SID>OelReplace('rx', nr2char(0xf782))
      inoremap <silent><expr> rz <SID>OelReplace('rz', nr2char(0xf783))
      inoremap <silent><expr> rf <SID>OelReplace('rf', nr2char(0xf784))
      inoremap <silent><expr> rd <SID>OelReplace('rd', nr2char(0xf785))
      inoremap <silent><expr> rs <SID>OelReplace('rs', nr2char(0xf786))
      inoremap <silent><expr> ra <SID>OelReplace('ra', nr2char(0xf787))
      inoremap <silent><expr> rr <SID>OelReplace('rr', nr2char(0xf788))
      inoremap <silent><expr> re <SID>OelReplace('re', nr2char(0xf789))
      inoremap <silent><expr> rw <SID>OelReplace('rw', nr2char(0xf78a))
      inoremap <silent><expr> rq <SID>OelReplace('rq', nr2char(0xf78b))
      inoremap <silent><expr> r4 <SID>OelReplace('r4', nr2char(0xf78c))
      inoremap <silent><expr> r3 <SID>OelReplace('r3', nr2char(0xf78d))
      inoremap <silent><expr> r2 <SID>OelReplace('r2', nr2char(0xf78e))
      inoremap <silent><expr> r1 <SID>OelReplace('r1', nr2char(0xf78f))
      inoremap <silent><expr> ev <SID>OelReplace('ev', nr2char(0xf790))
      inoremap <silent><expr> ec <SID>OelReplace('ec', nr2char(0xf791))
      inoremap <silent><expr> ex <SID>OelReplace('ex', nr2char(0xf792))
      inoremap <silent><expr> ez <SID>OelReplace('ez', nr2char(0xf793))
      inoremap <silent><expr> ef <SID>OelReplace('ef', nr2char(0xf794))
      inoremap <silent><expr> ed <SID>OelReplace('ed', nr2char(0xf795))
      inoremap <silent><expr> es <SID>OelReplace('es', nr2char(0xf796))
      inoremap <silent><expr> ea <SID>OelReplace('ea', nr2char(0xf797))
      inoremap <silent><expr> er <SID>OelReplace('er', nr2char(0xf798))
      inoremap <silent><expr> ee <SID>OelReplace('ee', nr2char(0xf799))
      inoremap <silent><expr> ew <SID>OelReplace('ew', nr2char(0xf79a))
      inoremap <silent><expr> eq <SID>OelReplace('eq', nr2char(0xf79b))
      inoremap <silent><expr> e4 <SID>OelReplace('e4', nr2char(0xf79c))
      inoremap <silent><expr> e3 <SID>OelReplace('e3', nr2char(0xf79d))
      inoremap <silent><expr> e2 <SID>OelReplace('e2', nr2char(0xf79e))
      inoremap <silent><expr> e1 <SID>OelReplace('e1', nr2char(0xf79f))
      inoremap <silent><expr> wv <SID>OelReplace('wv', nr2char(0xf7a0))
      inoremap <silent><expr> wc <SID>OelReplace('wc', nr2char(0xf7a1))
      inoremap <silent><expr> wx <SID>OelReplace('wx', nr2char(0xf7a2))
      inoremap <silent><expr> wz <SID>OelReplace('wz', nr2char(0xf7a3))
      inoremap <silent><expr> wf <SID>OelReplace('wf', nr2char(0xf7a4))
      inoremap <silent><expr> wd <SID>OelReplace('wd', nr2char(0xf7a5))
      inoremap <silent><expr> ws <SID>OelReplace('ws', nr2char(0xf7a6))
      inoremap <silent><expr> wa <SID>OelReplace('wa', nr2char(0xf7a7))
      inoremap <silent><expr> wr <SID>OelReplace('wr', nr2char(0xf7a8))
      inoremap <silent><expr> we <SID>OelReplace('we', nr2char(0xf7a9))
      inoremap <silent><expr> ww <SID>OelReplace('ww', nr2char(0xf7aa))
      inoremap <silent><expr> wq <SID>OelReplace('wq', nr2char(0xf7ab))
      inoremap <silent><expr> w4 <SID>OelReplace('w4', nr2char(0xf7ac))
      inoremap <silent><expr> w3 <SID>OelReplace('w3', nr2char(0xf7ad))
      inoremap <silent><expr> w2 <SID>OelReplace('w2', nr2char(0xf7ae))
      inoremap <silent><expr> w1 <SID>OelReplace('w1', nr2char(0xf7af))
      inoremap <silent><expr> qv <SID>OelReplace('qv', nr2char(0xf7b0))
      inoremap <silent><expr> qc <SID>OelReplace('qc', nr2char(0xf7b1))
      inoremap <silent><expr> qx <SID>OelReplace('qx', nr2char(0xf7b2))
      inoremap <silent><expr> qz <SID>OelReplace('qz', nr2char(0xf7b3))
      inoremap <silent><expr> qf <SID>OelReplace('qf', nr2char(0xf7b4))
      inoremap <silent><expr> qd <SID>OelReplace('qd', nr2char(0xf7b5))
      inoremap <silent><expr> qs <SID>OelReplace('qs', nr2char(0xf7b6))
      inoremap <silent><expr> qa <SID>OelReplace('qa', nr2char(0xf7b7))
      inoremap <silent><expr> qr <SID>OelReplace('qr', nr2char(0xf7b8))
      inoremap <silent><expr> qe <SID>OelReplace('qe', nr2char(0xf7b9))
      inoremap <silent><expr> qw <SID>OelReplace('qw', nr2char(0xf7ba))
      inoremap <silent><expr> qq <SID>OelReplace('qq', nr2char(0xf7bb))
      inoremap <silent><expr> q4 <SID>OelReplace('q4', nr2char(0xf7bc))
      inoremap <silent><expr> q3 <SID>OelReplace('q3', nr2char(0xf7bd))
      inoremap <silent><expr> q2 <SID>OelReplace('q2', nr2char(0xf7be))
      inoremap <silent><expr> q1 <SID>OelReplace('q1', nr2char(0xf7bf))
      inoremap <silent><expr> 4v <SID>OelReplace('4v', nr2char(0xf7c0))
      inoremap <silent><expr> 4c <SID>OelReplace('4c', nr2char(0xf7c1))
      inoremap <silent><expr> 4x <SID>OelReplace('4x', nr2char(0xf7c2))
      inoremap <silent><expr> 4z <SID>OelReplace('4z', nr2char(0xf7c3))
      inoremap <silent><expr> 4f <SID>OelReplace('4f', nr2char(0xf7c4))
      inoremap <silent><expr> 4d <SID>OelReplace('4d', nr2char(0xf7c5))
      inoremap <silent><expr> 4s <SID>OelReplace('4s', nr2char(0xf7c6))
      inoremap <silent><expr> 4a <SID>OelReplace('4a', nr2char(0xf7c7))
      inoremap <silent><expr> 4r <SID>OelReplace('4r', nr2char(0xf7c8))
      inoremap <silent><expr> 4e <SID>OelReplace('4e', nr2char(0xf7c9))
      inoremap <silent><expr> 4w <SID>OelReplace('4w', nr2char(0xf7ca))
      inoremap <silent><expr> 4q <SID>OelReplace('4q', nr2char(0xf7cb))
      inoremap <silent><expr> 44 <SID>OelReplace('44', nr2char(0xf7cc))
      inoremap <silent><expr> 43 <SID>OelReplace('43', nr2char(0xf7cd))
      inoremap <silent><expr> 42 <SID>OelReplace('42', nr2char(0xf7ce))
      inoremap <silent><expr> 41 <SID>OelReplace('41', nr2char(0xf7cf))
      inoremap <silent><expr> 3v <SID>OelReplace('3v', nr2char(0xf7d0))
      inoremap <silent><expr> 3c <SID>OelReplace('3c', nr2char(0xf7d1))
      inoremap <silent><expr> 3x <SID>OelReplace('3x', nr2char(0xf7d2))
      inoremap <silent><expr> 3z <SID>OelReplace('3z', nr2char(0xf7d3))
      inoremap <silent><expr> 3f <SID>OelReplace('3f', nr2char(0xf7d4))
      inoremap <silent><expr> 3d <SID>OelReplace('3d', nr2char(0xf7d5))
      inoremap <silent><expr> 3s <SID>OelReplace('3s', nr2char(0xf7d6))
      inoremap <silent><expr> 3a <SID>OelReplace('3a', nr2char(0xf7d7))
      inoremap <silent><expr> 3r <SID>OelReplace('3r', nr2char(0xf7d8))
      inoremap <silent><expr> 3e <SID>OelReplace('3e', nr2char(0xf7d9))
      inoremap <silent><expr> 3w <SID>OelReplace('3w', nr2char(0xf7da))
      inoremap <silent><expr> 3q <SID>OelReplace('3q', nr2char(0xf7db))
      inoremap <silent><expr> 34 <SID>OelReplace('34', nr2char(0xf7dc))
      inoremap <silent><expr> 33 <SID>OelReplace('33', nr2char(0xf7dd))
      inoremap <silent><expr> 32 <SID>OelReplace('32', nr2char(0xf7de))
      inoremap <silent><expr> 31 <SID>OelReplace('31', nr2char(0xf7df))
      inoremap <silent><expr> 2v <SID>OelReplace('2v', nr2char(0xf7e0))
      inoremap <silent><expr> 2c <SID>OelReplace('2c', nr2char(0xf7e1))
      inoremap <silent><expr> 2x <SID>OelReplace('2x', nr2char(0xf7e2))
      inoremap <silent><expr> 2z <SID>OelReplace('2z', nr2char(0xf7e3))
      inoremap <silent><expr> 2f <SID>OelReplace('2f', nr2char(0xf7e4))
      inoremap <silent><expr> 2d <SID>OelReplace('2d', nr2char(0xf7e5))
      inoremap <silent><expr> 2s <SID>OelReplace('2s', nr2char(0xf7e6))
      inoremap <silent><expr> 2a <SID>OelReplace('2a', nr2char(0xf7e7))
      inoremap <silent><expr> 2r <SID>OelReplace('2r', nr2char(0xf7e8))
      inoremap <silent><expr> 2e <SID>OelReplace('2e', nr2char(0xf7e9))
      inoremap <silent><expr> 2w <SID>OelReplace('2w', nr2char(0xf7ea))
      inoremap <silent><expr> 2q <SID>OelReplace('2q', nr2char(0xf7eb))
      inoremap <silent><expr> 24 <SID>OelReplace('24', nr2char(0xf7ec))
      inoremap <silent><expr> 23 <SID>OelReplace('23', nr2char(0xf7ed))
      inoremap <silent><expr> 22 <SID>OelReplace('22', nr2char(0xf7ee))
      inoremap <silent><expr> 21 <SID>OelReplace('21', nr2char(0xf7ef))
      inoremap <silent><expr> 1v <SID>OelReplace('1v', nr2char(0xf7f0))
      inoremap <silent><expr> 1c <SID>OelReplace('1c', nr2char(0xf7f1))
      inoremap <silent><expr> 1x <SID>OelReplace('1x', nr2char(0xf7f2))
      inoremap <silent><expr> 1z <SID>OelReplace('1z', nr2char(0xf7f3))
      inoremap <silent><expr> 1f <SID>OelReplace('1f', nr2char(0xf7f4))
      inoremap <silent><expr> 1d <SID>OelReplace('1d', nr2char(0xf7f5))
      inoremap <silent><expr> 1s <SID>OelReplace('1s', nr2char(0xf7f6))
      inoremap <silent><expr> 1a <SID>OelReplace('1a', nr2char(0xf7f7))
      inoremap <silent><expr> 1r <SID>OelReplace('1r', nr2char(0xf7f8))
      inoremap <silent><expr> 1e <SID>OelReplace('1e', nr2char(0xf7f9))
      inoremap <silent><expr> 1w <SID>OelReplace('1w', nr2char(0xf7fa))
      inoremap <silent><expr> 1q <SID>OelReplace('1q', nr2char(0xf7fb))
      inoremap <silent><expr> 14 <SID>OelReplace('14', nr2char(0xf7fc))
      inoremap <silent><expr> 13 <SID>OelReplace('13', nr2char(0xf7fd))
      inoremap <silent><expr> 12 <SID>OelReplace('12', nr2char(0xf7fe))
      inoremap <silent><expr> 11 <SID>OelReplace('11', nr2char(0xf7ff))
      let g:oelisspacepressed = 0
      py3 oel_listen_space.start()
    endif
  endfunction
  command! -nargs=0 Oelon call <SID>Oelon()

  function! s:Oeloff()
    if g:oelisspacepressed!=-1
      iunmap <silent><expr> vv
      iunmap <silent><expr> vc
      iunmap <silent><expr> vx
      iunmap <silent><expr> vz
      iunmap <silent><expr> vf
      iunmap <silent><expr> vd
      iunmap <silent><expr> vs
      iunmap <silent><expr> va
      iunmap <silent><expr> vr
      iunmap <silent><expr> ve
      iunmap <silent><expr> vw
      iunmap <silent><expr> vq
      iunmap <silent><expr> v4
      iunmap <silent><expr> v3
      iunmap <silent><expr> v2
      iunmap <silent><expr> v1
      iunmap <silent><expr> cv
      iunmap <silent><expr> cc
      iunmap <silent><expr> cx
      iunmap <silent><expr> cz
      iunmap <silent><expr> cf
      iunmap <silent><expr> cd
      iunmap <silent><expr> cs
      iunmap <silent><expr> ca
      iunmap <silent><expr> cr
      iunmap <silent><expr> ce
      iunmap <silent><expr> cw
      iunmap <silent><expr> cq
      iunmap <silent><expr> c4
      iunmap <silent><expr> c3
      iunmap <silent><expr> c2
      iunmap <silent><expr> c1
      iunmap <silent><expr> xv
      iunmap <silent><expr> xc
      iunmap <silent><expr> xx
      iunmap <silent><expr> xz
      iunmap <silent><expr> xf
      iunmap <silent><expr> xd
      iunmap <silent><expr> xs
      iunmap <silent><expr> xa
      iunmap <silent><expr> xr
      iunmap <silent><expr> xe
      iunmap <silent><expr> xw
      iunmap <silent><expr> xq
      iunmap <silent><expr> x4
      iunmap <silent><expr> x3
      iunmap <silent><expr> x2
      iunmap <silent><expr> x1
      iunmap <silent><expr> zv
      iunmap <silent><expr> zc
      iunmap <silent><expr> zx
      iunmap <silent><expr> zz
      iunmap <silent><expr> zf
      iunmap <silent><expr> zd
      iunmap <silent><expr> zs
      iunmap <silent><expr> za
      iunmap <silent><expr> zr
      iunmap <silent><expr> ze
      iunmap <silent><expr> zw
      iunmap <silent><expr> zq
      iunmap <silent><expr> z4
      iunmap <silent><expr> z3
      iunmap <silent><expr> z2
      iunmap <silent><expr> z1
      iunmap <silent><expr> fv
      iunmap <silent><expr> fc
      iunmap <silent><expr> fx
      iunmap <silent><expr> fz
      iunmap <silent><expr> ff
      iunmap <silent><expr> fd
      iunmap <silent><expr> fs
      iunmap <silent><expr> fa
      iunmap <silent><expr> fr
      iunmap <silent><expr> fe
      iunmap <silent><expr> fw
      iunmap <silent><expr> fq
      iunmap <silent><expr> f4
      iunmap <silent><expr> f3
      iunmap <silent><expr> f2
      iunmap <silent><expr> f1
      iunmap <silent><expr> dv
      iunmap <silent><expr> dc
      iunmap <silent><expr> dx
      iunmap <silent><expr> dz
      iunmap <silent><expr> df
      iunmap <silent><expr> dd
      iunmap <silent><expr> ds
      iunmap <silent><expr> da
      iunmap <silent><expr> dr
      iunmap <silent><expr> de
      iunmap <silent><expr> dw
      iunmap <silent><expr> dq
      iunmap <silent><expr> d4
      iunmap <silent><expr> d3
      iunmap <silent><expr> d2
      iunmap <silent><expr> d1
      iunmap <silent><expr> sv
      iunmap <silent><expr> sc
      iunmap <silent><expr> sx
      iunmap <silent><expr> sz
      iunmap <silent><expr> sf
      iunmap <silent><expr> sd
      iunmap <silent><expr> ss
      iunmap <silent><expr> sa
      iunmap <silent><expr> sr
      iunmap <silent><expr> se
      iunmap <silent><expr> sw
      iunmap <silent><expr> sq
      iunmap <silent><expr> s4
      iunmap <silent><expr> s3
      iunmap <silent><expr> s2
      iunmap <silent><expr> s1
      iunmap <silent><expr> av
      iunmap <silent><expr> ac
      iunmap <silent><expr> ax
      iunmap <silent><expr> az
      iunmap <silent><expr> af
      iunmap <silent><expr> ad
      iunmap <silent><expr> as
      iunmap <silent><expr> aa
      iunmap <silent><expr> ar
      iunmap <silent><expr> ae
      iunmap <silent><expr> aw
      iunmap <silent><expr> aq
      iunmap <silent><expr> a4
      iunmap <silent><expr> a3
      iunmap <silent><expr> a2
      iunmap <silent><expr> a1
      iunmap <silent><expr> rv
      iunmap <silent><expr> rc
      iunmap <silent><expr> rx
      iunmap <silent><expr> rz
      iunmap <silent><expr> rf
      iunmap <silent><expr> rd
      iunmap <silent><expr> rs
      iunmap <silent><expr> ra
      iunmap <silent><expr> rr
      iunmap <silent><expr> re
      iunmap <silent><expr> rw
      iunmap <silent><expr> rq
      iunmap <silent><expr> r4
      iunmap <silent><expr> r3
      iunmap <silent><expr> r2
      iunmap <silent><expr> r1
      iunmap <silent><expr> ev
      iunmap <silent><expr> ec
      iunmap <silent><expr> ex
      iunmap <silent><expr> ez
      iunmap <silent><expr> ef
      iunmap <silent><expr> ed
      iunmap <silent><expr> es
      iunmap <silent><expr> ea
      iunmap <silent><expr> er
      iunmap <silent><expr> ee
      iunmap <silent><expr> ew
      iunmap <silent><expr> eq
      iunmap <silent><expr> e4
      iunmap <silent><expr> e3
      iunmap <silent><expr> e2
      iunmap <silent><expr> e1
      iunmap <silent><expr> wv
      iunmap <silent><expr> wc
      iunmap <silent><expr> wx
      iunmap <silent><expr> wz
      iunmap <silent><expr> wf
      iunmap <silent><expr> wd
      iunmap <silent><expr> ws
      iunmap <silent><expr> wa
      iunmap <silent><expr> wr
      iunmap <silent><expr> we
      iunmap <silent><expr> ww
      iunmap <silent><expr> wq
      iunmap <silent><expr> w4
      iunmap <silent><expr> w3
      iunmap <silent><expr> w2
      iunmap <silent><expr> w1
      iunmap <silent><expr> qv
      iunmap <silent><expr> qc
      iunmap <silent><expr> qx
      iunmap <silent><expr> qz
      iunmap <silent><expr> qf
      iunmap <silent><expr> qd
      iunmap <silent><expr> qs
      iunmap <silent><expr> qa
      iunmap <silent><expr> qr
      iunmap <silent><expr> qe
      iunmap <silent><expr> qw
      iunmap <silent><expr> qq
      iunmap <silent><expr> q4
      iunmap <silent><expr> q3
      iunmap <silent><expr> q2
      iunmap <silent><expr> q1
      iunmap <silent><expr> 4v
      iunmap <silent><expr> 4c
      iunmap <silent><expr> 4x
      iunmap <silent><expr> 4z
      iunmap <silent><expr> 4f
      iunmap <silent><expr> 4d
      iunmap <silent><expr> 4s
      iunmap <silent><expr> 4a
      iunmap <silent><expr> 4r
      iunmap <silent><expr> 4e
      iunmap <silent><expr> 4w
      iunmap <silent><expr> 4q
      iunmap <silent><expr> 44
      iunmap <silent><expr> 43
      iunmap <silent><expr> 42
      iunmap <silent><expr> 41
      iunmap <silent><expr> 3v
      iunmap <silent><expr> 3c
      iunmap <silent><expr> 3x
      iunmap <silent><expr> 3z
      iunmap <silent><expr> 3f
      iunmap <silent><expr> 3d
      iunmap <silent><expr> 3s
      iunmap <silent><expr> 3a
      iunmap <silent><expr> 3r
      iunmap <silent><expr> 3e
      iunmap <silent><expr> 3w
      iunmap <silent><expr> 3q
      iunmap <silent><expr> 34
      iunmap <silent><expr> 33
      iunmap <silent><expr> 32
      iunmap <silent><expr> 31
      iunmap <silent><expr> 2v
      iunmap <silent><expr> 2c
      iunmap <silent><expr> 2x
      iunmap <silent><expr> 2z
      iunmap <silent><expr> 2f
      iunmap <silent><expr> 2d
      iunmap <silent><expr> 2s
      iunmap <silent><expr> 2a
      iunmap <silent><expr> 2r
      iunmap <silent><expr> 2e
      iunmap <silent><expr> 2w
      iunmap <silent><expr> 2q
      iunmap <silent><expr> 24
      iunmap <silent><expr> 23
      iunmap <silent><expr> 22
      iunmap <silent><expr> 21
      iunmap <silent><expr> 1v
      iunmap <silent><expr> 1c
      iunmap <silent><expr> 1x
      iunmap <silent><expr> 1z
      iunmap <silent><expr> 1f
      iunmap <silent><expr> 1d
      iunmap <silent><expr> 1s
      iunmap <silent><expr> 1a
      iunmap <silent><expr> 1r
      iunmap <silent><expr> 1e
      iunmap <silent><expr> 1w
      iunmap <silent><expr> 1q
      iunmap <silent><expr> 14
      iunmap <silent><expr> 13
      iunmap <silent><expr> 12
      iunmap <silent><expr> 11
      py3 oel_listen_space.stop()
      let g:oelisspacepressed = -1
    endif
  endfunction
  command! -nargs=0 Oeloff call <SID>Oeloff()
endif

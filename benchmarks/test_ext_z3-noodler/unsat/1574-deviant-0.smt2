(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var990 0)
(declare-sort var1294 0)
(declare-sort var3283 0)
(declare-sort var3717 0)
(declare-sort var1504 0)
(declare-sort var3876 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun name/-785846261 (var990) String)
(declare-fun type/-785846261 (var990) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun var1504-init () var1504)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun <init>/1587308532 (var1504 var3876 var3876) void)
(declare-fun cast-from-Int-to-var3876 (Int) var3876)
(declare-const null-var990 var990)
(declare-const null-String String)
(declare-const null-var3283 var3283)
(declare-const null-var3717 var3717)
(declare-const var1078 var990) ; Statement: r1 := @parameter0: org.antlr.v4.tool.Attribute 
(assert (not (= var1078 null-var990)))
(declare-const var1392 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var1392 null-String)))
(declare-const var3086 var3283) ; Statement: r12 := @parameter2: org.antlr.v4.tool.ast.ActionAST 
(assert (not (= var3086 null-var3283)))
(declare-const var3525 var3717) ; Statement: r10 := @parameter3: org.antlr.v4.tool.Grammar 
(assert (not (= var3525 null-var3717)))
(define-const var1755 Int (cast-from-Int-to-Int -1)) ; Statement: $i14 = (int) -1 
(define-const var635 Int var1755) ; Statement: i6 = $i14 
(define-const var2137 Int (cast-from-Int-to-Int -1)) ; Statement: $i16 = (int) -1 
(define-const var3449 Int var2137) ; Statement: i7 = $i16 
(assert true)
(define-const var1045 Int (indexOf/-1037706067 var1392 58)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(58) 
(define-const var3196 Int (cast-from-Int-to-Int -1)) ; Statement: $i18 = (int) -1 
 ; Statement: if i0 != $i18 goto $i8 = i0 
(assert (not (= var1045 var3196))) ; Cond: i0 != $i18 
(define-const var1884 Int var1045) ; Statement: $i8 = i0 
(assert true) ; Non Conditional
(define-const var2408 Int var1884) ; Statement: i1 = $i8 
(define-const var323 Int 0) ; Statement: i9 = 0 
(assert true) ; Non Conditional
 ; Statement: if i9 >= i1 goto $i21 = (int) -1 
(assert (>= var323 var2408)) ; Cond: i9 >= i1 
(define-const var110 Int (cast-from-Int-to-Int -1)) ; Statement: $i21 = (int) -1 
 ; Statement: if i6 != $i21 goto i11 = i6 
(assert (not (= var635 var110))) ; Cond: i6 != $i21 
(define-const var3246 Int var635) ; Statement: i11 = i6 
(assert true) ; Non Conditional
 ; Statement: if i11 >= i1 goto $i24 = (int) -1 
(assert (>= var3246 var2408)) ; Cond: i11 >= i1 
(define-const var1207 Int (cast-from-Int-to-Int -1)) ; Statement: $i24 = (int) -1 
 ; Statement: if i7 != $i24 goto $r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i6, i7) 
(assert (not (= var3449 var1207))) ; Cond: i7 != $i24 
(assert (not (and true (and (>= var635 0) (>= (str.len var1392) var3449) (>= var3449 var635)))))
(check-sat)
; {cast-from-Int-to-Int=([int], int), indexOf/-1037706067=([java.lang.String, int], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), name/-785846261=([org.antlr.v4.tool.Attribute], java.lang.String), type/-785846261=([org.antlr.v4.tool.Attribute], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String), length/-134980193=([java.lang.String], int), var1504-init=([], org.antlr.v4.runtime.misc.Pair), Int_valueOf/-1371140006=([int], java.lang.Integer), <init>/1587308532=([org.antlr.v4.runtime.misc.Pair, java.lang.Object, java.lang.Object], void), cast-from-Int-to-var3876=([java.lang.Integer], java.lang.Object)}
; {var990=org.antlr.v4.tool.Attribute, var1078=r1, var1392=r0, var1294=null_type, var3283=org.antlr.v4.tool.ast.ActionAST, var3086=r12, var3717=org.antlr.v4.tool.Grammar, var3525=r10, var1755=$i14, var635=i6, var2137=$i16, var3449=i7, var1045=i0, var3196=$i18, var1884=$i8, var2408=i1, var323=i9, var110=$i21, var3246=i11, var1207=$i24, var3197=$r2, var2273=$i26, var3282=$r4, var1527=$r5, var2390=$r6, var2056=$i4, var1504=org.antlr.v4.runtime.misc.Pair, var271=$r18, var3559=$r9, var2953=$r8, var3876=java.lang.Object}
; {org.antlr.v4.tool.Attribute=var990, r1=var1078, r0=var1392, null_type=var1294, org.antlr.v4.tool.ast.ActionAST=var3283, r12=var3086, org.antlr.v4.tool.Grammar=var3717, r10=var3525, $i14=var1755, i6=var635, $i16=var2137, i7=var3449, i0=var1045, $i18=var3196, $i8=var1884, i1=var2408, i9=var323, $i21=var110, i11=var3246, $i24=var1207, $r2=var3197, $i26=var2273, $r4=var3282, $r5=var1527, $r6=var2390, $i4=var2056, org.antlr.v4.runtime.misc.Pair=var1504, $r18=var271, $r9=var3559, $r8=var2953, java.lang.Object=var3876}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String trim()>;	<java.lang.String: int length()>
;cnt {"<java.lang.String: int indexOf(int)>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: int length()>": 1}
;stmts r1 := @parameter0: org.antlr.v4.tool.Attribute;	r0 := @parameter1: java.lang.String;	r12 := @parameter2: org.antlr.v4.tool.ast.ActionAST;	r10 := @parameter3: org.antlr.v4.tool.Grammar;	$i14 = (int) -1;	i6 = $i14;	$i16 = (int) -1;	i7 = $i16;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(58);	$i18 = (int) -1;	if i0 != $i18 goto $i8 = i0;	$i8 = i0;	i1 = $i8;	i9 = 0;	if i9 >= i1 goto $i21 = (int) -1;	$i21 = (int) -1;	if i6 != $i21 goto i11 = i6;	i11 = i6;	if i11 >= i1 goto $i24 = (int) -1;	$i24 = (int) -1;	if i7 != $i24 goto $r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i6, i7);	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i6, i7);	r1.<org.antlr.v4.tool.Attribute: java.lang.String name> = $r2;	$i26 = (int) -1;	if i0 != $i26 goto $i3 = i0 + 1;	r1.<org.antlr.v4.tool.Attribute: java.lang.String type> = "";	goto [?= $r4 = r1.<org.antlr.v4.tool.Attribute: java.lang.String type>];	$r4 = r1.<org.antlr.v4.tool.Attribute: java.lang.String type>;	$r5 = virtualinvoke $r4.<java.lang.String: java.lang.String trim()>();	r1.<org.antlr.v4.tool.Attribute: java.lang.String type> = $r5;	$r6 = r1.<org.antlr.v4.tool.Attribute: java.lang.String type>;	$i4 = virtualinvoke $r6.<java.lang.String: int length()>();	if $i4 != 0 goto $r18 = new org.antlr.v4.runtime.misc.Pair;	$r18 = new org.antlr.v4.runtime.misc.Pair;	$r9 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i6);	$r8 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i7);	specialinvoke $r18.<org.antlr.v4.runtime.misc.Pair: void <init>(java.lang.Object,java.lang.Object)>($r9, $r8);	return $r18
;block_num 12
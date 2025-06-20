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

(declare-sort var2749 0)
(declare-sort var2155 0)
(declare-sort var2805 0)
(declare-sort var268 0)
(declare-sort var2132 0)
(declare-sort var1314 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun name/-785846261 (var2749) String)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun type/-785846261 (var2749) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun var2132-init () var2132)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun <init>/1587308532 (var2132 var1314 var1314) void)
(declare-fun cast-from-Int-to-var1314 (Int) var1314)
(declare-const null-var2749 var2749)
(declare-const null-String String)
(declare-const null-var2805 var2805)
(declare-const null-var268 var268)
(declare-const var1949 var2749) ; Statement: r1 := @parameter0: org.antlr.v4.tool.Attribute 
(assert (not (= var1949 null-var2749)))
(declare-const var2907 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2907 null-String)))
(declare-const var2676 var2805) ; Statement: r12 := @parameter2: org.antlr.v4.tool.ast.ActionAST 
(assert (not (= var2676 null-var2805)))
(declare-const var1952 var268) ; Statement: r10 := @parameter3: org.antlr.v4.tool.Grammar 
(assert (not (= var1952 null-var268)))
(define-const var2892 Int (cast-from-Int-to-Int -1)) ; Statement: $i14 = (int) -1 
(define-const var1 Int var2892) ; Statement: i6 = $i14 
(define-const var1050 Int (cast-from-Int-to-Int -1)) ; Statement: $i16 = (int) -1 
(define-const var2832 Int var1050) ; Statement: i7 = $i16 
(assert true)
(define-const var2559 Int (indexOf/-1037706067 var2907 58)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(58) 
(define-const var3272 Int (cast-from-Int-to-Int -1)) ; Statement: $i18 = (int) -1 
 ; Statement: if i0 != $i18 goto $i8 = i0 
(assert (not (= var2559 var3272))) ; Cond: i0 != $i18 
(define-const var454 Int var2559) ; Statement: $i8 = i0 
(assert true) ; Non Conditional
(define-const var1378 Int var454) ; Statement: i1 = $i8 
(define-const var1950 Int 0) ; Statement: i9 = 0 
(assert true) ; Non Conditional
 ; Statement: if i9 >= i1 goto $i21 = (int) -1 
(assert (>= var1950 var1378)) ; Cond: i9 >= i1 
(define-const var1109 Int (cast-from-Int-to-Int -1)) ; Statement: $i21 = (int) -1 
 ; Statement: if i6 != $i21 goto i11 = i6 
(assert (not (= var1 var1109))) ; Cond: i6 != $i21 
(define-const var2507 Int var1) ; Statement: i11 = i6 
(assert true) ; Non Conditional
 ; Statement: if i11 >= i1 goto $i24 = (int) -1 
(assert (>= var2507 var1378)) ; Cond: i11 >= i1 
(define-const var1322 Int (cast-from-Int-to-Int -1)) ; Statement: $i24 = (int) -1 
 ; Statement: if i7 != $i24 goto $r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i6, i7) 
(assert (not (= var2832 var1322))) ; Cond: i7 != $i24 
(assert (not (and true (and (>= var1 0) (>= (str.len var2907) var2832) (>= var2832 var1)))))
(check-sat)
; {cast-from-Int-to-Int=([int], int), indexOf/-1037706067=([java.lang.String, int], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), name/-785846261=([org.antlr.v4.tool.Attribute], java.lang.String), length/-134980193=([java.lang.String], int), type/-785846261=([org.antlr.v4.tool.Attribute], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String), var2132-init=([], org.antlr.v4.runtime.misc.Pair), Int_valueOf/-1371140006=([int], java.lang.Integer), <init>/1587308532=([org.antlr.v4.runtime.misc.Pair, java.lang.Object, java.lang.Object], void), cast-from-Int-to-var1314=([java.lang.Integer], java.lang.Object)}
; {var2749=org.antlr.v4.tool.Attribute, var1949=r1, var2907=r0, var2155=null_type, var2805=org.antlr.v4.tool.ast.ActionAST, var2676=r12, var268=org.antlr.v4.tool.Grammar, var1952=r10, var2892=$i14, var1=i6, var1050=$i16, var2832=i7, var2559=i0, var3272=$i18, var454=$i8, var1378=i1, var1950=i9, var1109=$i21, var2507=i11, var1322=$i24, var3642=$r2, var2883=$i26, var1290=$i3, var1694=$i2, var3513=$r3, var3736=$r4, var3321=$r5, var2403=$r6, var3310=$i4, var2132=org.antlr.v4.runtime.misc.Pair, var3542=$r18, var731=$r9, var2236=$r8, var1314=java.lang.Object}
; {org.antlr.v4.tool.Attribute=var2749, r1=var1949, r0=var2907, null_type=var2155, org.antlr.v4.tool.ast.ActionAST=var2805, r12=var2676, org.antlr.v4.tool.Grammar=var268, r10=var1952, $i14=var2892, i6=var1, $i16=var1050, i7=var2832, i0=var2559, $i18=var3272, $i8=var454, i1=var1378, i9=var1950, $i21=var1109, i11=var2507, $i24=var1322, $r2=var3642, $i26=var2883, $i3=var1290, $i2=var1694, $r3=var3513, $r4=var3736, $r5=var3321, $r6=var2403, $i4=var3310, org.antlr.v4.runtime.misc.Pair=var2132, $r18=var3542, $r9=var731, $r8=var2236, java.lang.Object=var1314}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String trim()>;	<java.lang.String: int length()>
;cnt {"<java.lang.String: int indexOf(int)>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 2,"<java.lang.String: int length()>": 2,"<java.lang.String: java.lang.String trim()>": 1}
;stmts r1 := @parameter0: org.antlr.v4.tool.Attribute;	r0 := @parameter1: java.lang.String;	r12 := @parameter2: org.antlr.v4.tool.ast.ActionAST;	r10 := @parameter3: org.antlr.v4.tool.Grammar;	$i14 = (int) -1;	i6 = $i14;	$i16 = (int) -1;	i7 = $i16;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(58);	$i18 = (int) -1;	if i0 != $i18 goto $i8 = i0;	$i8 = i0;	i1 = $i8;	i9 = 0;	if i9 >= i1 goto $i21 = (int) -1;	$i21 = (int) -1;	if i6 != $i21 goto i11 = i6;	i11 = i6;	if i11 >= i1 goto $i24 = (int) -1;	$i24 = (int) -1;	if i7 != $i24 goto $r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i6, i7);	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i6, i7);	r1.<org.antlr.v4.tool.Attribute: java.lang.String name> = $r2;	$i26 = (int) -1;	if i0 != $i26 goto $i3 = i0 + 1;	$i3 = i0 + 1;	$i2 = virtualinvoke r0.<java.lang.String: int length()>();	$r3 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>($i3, $i2);	r1.<org.antlr.v4.tool.Attribute: java.lang.String type> = $r3;	$r4 = r1.<org.antlr.v4.tool.Attribute: java.lang.String type>;	$r5 = virtualinvoke $r4.<java.lang.String: java.lang.String trim()>();	r1.<org.antlr.v4.tool.Attribute: java.lang.String type> = $r5;	$r6 = r1.<org.antlr.v4.tool.Attribute: java.lang.String type>;	$i4 = virtualinvoke $r6.<java.lang.String: int length()>();	if $i4 != 0 goto $r18 = new org.antlr.v4.runtime.misc.Pair;	$r18 = new org.antlr.v4.runtime.misc.Pair;	$r9 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i6);	$r8 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i7);	specialinvoke $r18.<org.antlr.v4.runtime.misc.Pair: void <init>(java.lang.Object,java.lang.Object)>($r9, $r8);	return $r18
;block_num 12
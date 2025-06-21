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

(declare-sort var2911 0)
(declare-sort var641 0)
(declare-sort var1344 0)
(declare-sort var3306 0)
(declare-sort var667 0)
(declare-sort var2419 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun name/-785846261 (var2911) String)
(declare-fun type/-785846261 (var2911) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun var667-init () var667)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun <init>/1587308532 (var667 var2419 var2419) void)
(declare-fun cast-from-Int-to-var2419 (Int) var2419)
(declare-const null-var2911 var2911)
(declare-const null-String String)
(declare-const null-var1344 var1344)
(declare-const null-var3306 var3306)
(declare-const var1293 var2911) ; Statement: r1 := @parameter0: org.antlr.v4.tool.Attribute 
(assert (not (= var1293 null-var2911)))
(declare-const var48 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var48 null-String)))
(declare-const var3300 var1344) ; Statement: r12 := @parameter2: org.antlr.v4.tool.ast.ActionAST 
(assert (not (= var3300 null-var1344)))
(declare-const var3513 var3306) ; Statement: r10 := @parameter3: org.antlr.v4.tool.Grammar 
(assert (not (= var3513 null-var3306)))
(define-const var363 Int (cast-from-Int-to-Int -1)) ; Statement: $i14 = (int) -1 
(define-const var3744 Int var363) ; Statement: i6 = $i14 
(define-const var2719 Int (cast-from-Int-to-Int -1)) ; Statement: $i16 = (int) -1 
(define-const var827 Int var2719) ; Statement: i7 = $i16 
(assert true)
(define-const var805 Int (indexOf/-1037706067 var48 58)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(58) 
(define-const var2101 Int (cast-from-Int-to-Int -1)) ; Statement: $i18 = (int) -1 
 ; Statement: if i0 != $i18 goto $i8 = i0 
(assert (not (not (= var805 var2101)))) ; Negate: Cond: i0 != $i18  
(assert true)
(define-const var1850 Int (length/-134980193 var48)) ; Statement: $i8 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: goto [?= i1 = $i8] 
(assert true) ; Non Conditional
(define-const var766 Int var1850) ; Statement: i1 = $i8 
(define-const var3229 Int 0) ; Statement: i9 = 0 
(assert true) ; Non Conditional
 ; Statement: if i9 >= i1 goto $i21 = (int) -1 
(assert (>= var3229 var766)) ; Cond: i9 >= i1 
(define-const var3219 Int (cast-from-Int-to-Int -1)) ; Statement: $i21 = (int) -1 
 ; Statement: if i6 != $i21 goto i11 = i6 
(assert (not (= var3744 var3219))) ; Cond: i6 != $i21 
(define-const var2159 Int var3744) ; Statement: i11 = i6 
(assert true) ; Non Conditional
 ; Statement: if i11 >= i1 goto $i24 = (int) -1 
(assert (>= var2159 var766)) ; Cond: i11 >= i1 
(define-const var1048 Int (cast-from-Int-to-Int -1)) ; Statement: $i24 = (int) -1 
 ; Statement: if i7 != $i24 goto $r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i6, i7) 
(assert (not (= var827 var1048))) ; Cond: i7 != $i24 
(assert (not (and true (and (>= var3744 0) (>= (str.len var48) var827) (>= var827 var3744)))))
(check-sat)
; {cast-from-Int-to-Int=([int], int), indexOf/-1037706067=([java.lang.String, int], int), length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), name/-785846261=([org.antlr.v4.tool.Attribute], java.lang.String), type/-785846261=([org.antlr.v4.tool.Attribute], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String), var667-init=([], org.antlr.v4.runtime.misc.Pair), Int_valueOf/-1371140006=([int], java.lang.Integer), <init>/1587308532=([org.antlr.v4.runtime.misc.Pair, java.lang.Object, java.lang.Object], void), cast-from-Int-to-var2419=([java.lang.Integer], java.lang.Object)}
; {var2911=org.antlr.v4.tool.Attribute, var1293=r1, var48=r0, var641=null_type, var1344=org.antlr.v4.tool.ast.ActionAST, var3300=r12, var3306=org.antlr.v4.tool.Grammar, var3513=r10, var363=$i14, var3744=i6, var2719=$i16, var827=i7, var805=i0, var2101=$i18, var1850=$i8, var766=i1, var3229=i9, var3219=$i21, var2159=i11, var1048=$i24, var2959=$r2, var1909=$i26, var2550=$i3, var3656=$i2, var855=$r3, var381=$r4, var308=$r5, var2228=$r6, var2249=$i4, var667=org.antlr.v4.runtime.misc.Pair, var1477=$r18, var446=$r9, var786=$r8, var2419=java.lang.Object}
; {org.antlr.v4.tool.Attribute=var2911, r1=var1293, r0=var48, null_type=var641, org.antlr.v4.tool.ast.ActionAST=var1344, r12=var3300, org.antlr.v4.tool.Grammar=var3306, r10=var3513, $i14=var363, i6=var3744, $i16=var2719, i7=var827, i0=var805, $i18=var2101, $i8=var1850, i1=var766, i9=var3229, $i21=var3219, i11=var2159, $i24=var1048, $r2=var2959, $i26=var1909, $i3=var2550, $i2=var3656, $r3=var855, $r4=var381, $r5=var308, $r6=var2228, $i4=var2249, org.antlr.v4.runtime.misc.Pair=var667, $r18=var1477, $r9=var446, $r8=var786, java.lang.Object=var2419}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String trim()>;	<java.lang.String: int length()>
;cnt {"<java.lang.String: int indexOf(int)>": 1,"<java.lang.String: int length()>": 3,"<java.lang.String: java.lang.String substring(int,int)>": 2,"<java.lang.String: java.lang.String trim()>": 1}
;stmts r1 := @parameter0: org.antlr.v4.tool.Attribute;	r0 := @parameter1: java.lang.String;	r12 := @parameter2: org.antlr.v4.tool.ast.ActionAST;	r10 := @parameter3: org.antlr.v4.tool.Grammar;	$i14 = (int) -1;	i6 = $i14;	$i16 = (int) -1;	i7 = $i16;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(58);	$i18 = (int) -1;	if i0 != $i18 goto $i8 = i0;	$i8 = virtualinvoke r0.<java.lang.String: int length()>();	goto [?= i1 = $i8];	i1 = $i8;	i9 = 0;	if i9 >= i1 goto $i21 = (int) -1;	$i21 = (int) -1;	if i6 != $i21 goto i11 = i6;	i11 = i6;	if i11 >= i1 goto $i24 = (int) -1;	$i24 = (int) -1;	if i7 != $i24 goto $r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i6, i7);	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i6, i7);	r1.<org.antlr.v4.tool.Attribute: java.lang.String name> = $r2;	$i26 = (int) -1;	if i0 != $i26 goto $i3 = i0 + 1;	$i3 = i0 + 1;	$i2 = virtualinvoke r0.<java.lang.String: int length()>();	$r3 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>($i3, $i2);	r1.<org.antlr.v4.tool.Attribute: java.lang.String type> = $r3;	$r4 = r1.<org.antlr.v4.tool.Attribute: java.lang.String type>;	$r5 = virtualinvoke $r4.<java.lang.String: java.lang.String trim()>();	r1.<org.antlr.v4.tool.Attribute: java.lang.String type> = $r5;	$r6 = r1.<org.antlr.v4.tool.Attribute: java.lang.String type>;	$i4 = virtualinvoke $r6.<java.lang.String: int length()>();	if $i4 != 0 goto $r18 = new org.antlr.v4.runtime.misc.Pair;	$r18 = new org.antlr.v4.runtime.misc.Pair;	$r9 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i6);	$r8 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i7);	specialinvoke $r18.<org.antlr.v4.runtime.misc.Pair: void <init>(java.lang.Object,java.lang.Object)>($r9, $r8);	return $r18
;block_num 12
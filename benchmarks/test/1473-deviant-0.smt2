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

(declare-sort var602 0)
(declare-sort var2389 0)
(declare-sort var1116 0)
(declare-sort var3364 0)
(declare-sort var3692 0)
(declare-sort var1688 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun name/-785846261 (var602) String)
(declare-fun type/-785846261 (var602) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun var3692-init () var3692)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun <init>/1587308532 (var3692 var1688 var1688) void)
(declare-fun cast-from-Int-to-var1688 (Int) var1688)
(declare-const null-var602 var602)
(declare-const null-String String)
(declare-const null-var1116 var1116)
(declare-const null-var3364 var3364)
(declare-const var1675 var602) ; Statement: r1 := @parameter0: org.antlr.v4.tool.Attribute 
(assert (not (= var1675 null-var602)))
(declare-const var1278 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var1278 null-String)))
(declare-const var1891 var1116) ; Statement: r15 := @parameter2: org.antlr.v4.tool.ast.ActionAST 
(assert (not (= var1891 null-var1116)))
(declare-const var3502 var3364) ; Statement: r13 := @parameter3: org.antlr.v4.tool.Grammar 
(assert (not (= var3502 null-var3364)))
(define-const var176 Bool (ite (= 1 0) true false)) ; Statement: z3 = 0 
(define-const var310 Bool (ite (= 1 0) true false)) ; Statement: z6 = 0 
(define-const var1308 Bool (ite (= 1 0) true false)) ; Statement: z5 = 0 
(define-const var841 Bool (ite (= 1 0) true false)) ; Statement: z4 = 0 
(define-const var618 Int (cast-from-Int-to-Int -1)) ; Statement: $i15 = (int) -1 
(define-const var3427 Int var618) ; Statement: i8 = $i15 
(assert true)
(define-const var40 Int (length/-134980193 var1278)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(define-const var3647 Int (- var40 1)) ; Statement: i9 = $i0 - 1 
(assert true) ; Non Conditional
 ; Statement: if i9 < 0 goto (branch) 
(assert (< var3647 0)) ; Cond: i9 < 0 
 ; Statement: if i8 >= 0 goto (branch) 
(assert (>= var3427 0)) ; Cond: i8 >= 0 
 ; Statement: if i8 >= 0 goto $i20 = (int) -1 
(assert (>= var3427 0)) ; Cond: i8 >= 0 
(define-const var3533 Int (cast-from-Int-to-Int -1)) ; Statement: $i20 = (int) -1 
(define-const var2643 Int var3533) ; Statement: i11 = $i20 
(define-const var1581 Int var3427) ; Statement: i12 = i8 
(assert true) ; Non Conditional
(assert true)
(define-const var587 Int (length/-134980193 var1278)) ; Statement: $i13 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: if i12 >= $i13 goto $r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i8, i11) 
(assert (>= var1581 var587)) ; Cond: i12 >= $i13 
(assert (not (and true (and (>= var3427 0) (>= (str.len var1278) var2643) (>= var2643 var3427)))))
(check-sat)
; {cast-from-Int-to-Int=([int], int), length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), name/-785846261=([org.antlr.v4.tool.Attribute], java.lang.String), type/-785846261=([org.antlr.v4.tool.Attribute], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String), var3692-init=([], org.antlr.v4.runtime.misc.Pair), Int_valueOf/-1371140006=([int], java.lang.Integer), <init>/1587308532=([org.antlr.v4.runtime.misc.Pair, java.lang.Object, java.lang.Object], void), cast-from-Int-to-var1688=([java.lang.Integer], java.lang.Object)}
; {var602=org.antlr.v4.tool.Attribute, var1675=r1, var1278=r0, var2389=null_type, var1116=org.antlr.v4.tool.ast.ActionAST, var1891=r15, var3364=org.antlr.v4.tool.Grammar, var3502=r13, var176=z3, var310=z6, var1308=z5, var841=z4, var618=$i15, var3427=i8, var40=$i0, var3647=i9, var3533=$i20, var2643=i11, var1581=i12, var587=$i13, var3908=$r2, var1497=$r3, var779=$i1, var2913=$i2, var1857=$r4, var713=$r5, var1306=$r6, var3086=$i3, var3692=org.antlr.v4.runtime.misc.Pair, var2085=$r21, var2911=$r9, var3436=$r8, var1688=java.lang.Object}
; {org.antlr.v4.tool.Attribute=var602, r1=var1675, r0=var1278, null_type=var2389, org.antlr.v4.tool.ast.ActionAST=var1116, r15=var1891, org.antlr.v4.tool.Grammar=var3364, r13=var3502, z3=var176, z6=var310, z5=var1308, z4=var841, $i15=var618, i8=var3427, $i0=var40, i9=var3647, $i20=var3533, i11=var2643, i12=var1581, $i13=var587, $r2=var3908, $r3=var1497, $i1=var779, $i2=var2913, $r4=var1857, $r5=var713, $r6=var1306, $i3=var3086, org.antlr.v4.runtime.misc.Pair=var3692, $r21=var2085, $r9=var2911, $r8=var3436, java.lang.Object=var1688}
;seq <java.lang.String: int length()>;	<java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: int length()>;	<java.lang.String: java.lang.String trim()>;	<java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 4,"<java.lang.String: java.lang.String substring(int,int)>": 2,"<java.lang.String: java.lang.String trim()>": 1}
;stmts r1 := @parameter0: org.antlr.v4.tool.Attribute;	r0 := @parameter1: java.lang.String;	r15 := @parameter2: org.antlr.v4.tool.ast.ActionAST;	r13 := @parameter3: org.antlr.v4.tool.Grammar;	z3 = 0;	z6 = 0;	z5 = 0;	z4 = 0;	$i15 = (int) -1;	i8 = $i15;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	i9 = $i0 - 1;	if i9 < 0 goto (branch);	if i8 >= 0 goto (branch);	if i8 >= 0 goto $i20 = (int) -1;	$i20 = (int) -1;	i11 = $i20;	i12 = i8;	$i13 = virtualinvoke r0.<java.lang.String: int length()>();	if i12 >= $i13 goto $r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i8, i11);	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i8, i11);	r1.<org.antlr.v4.tool.Attribute: java.lang.String name> = $r2;	$r3 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i8);	r1.<org.antlr.v4.tool.Attribute: java.lang.String type> = $r3;	$i1 = virtualinvoke r0.<java.lang.String: int length()>();	$i2 = $i1 - 1;	if i11 > $i2 goto $r4 = r1.<org.antlr.v4.tool.Attribute: java.lang.String type>;	$r4 = r1.<org.antlr.v4.tool.Attribute: java.lang.String type>;	$r5 = virtualinvoke $r4.<java.lang.String: java.lang.String trim()>();	r1.<org.antlr.v4.tool.Attribute: java.lang.String type> = $r5;	$r6 = r1.<org.antlr.v4.tool.Attribute: java.lang.String type>;	$i3 = virtualinvoke $r6.<java.lang.String: int length()>();	if $i3 != 0 goto $r21 = new org.antlr.v4.runtime.misc.Pair;	$r21 = new org.antlr.v4.runtime.misc.Pair;	$r9 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i8);	$r8 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i11);	specialinvoke $r21.<org.antlr.v4.runtime.misc.Pair: void <init>(java.lang.Object,java.lang.Object)>($r9, $r8);	return $r21
;block_num 9
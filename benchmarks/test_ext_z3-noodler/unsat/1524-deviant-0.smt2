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

(declare-sort var3116 0)
(declare-sort var212 0)
(declare-sort var26 0)
(declare-sort var93 0)
(declare-sort var1603 0)
(declare-sort var931 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun name/-785846261 (var3116) String)
(declare-fun type/-785846261 (var3116) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun var1603-init () var1603)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun <init>/1587308532 (var1603 var931 var931) void)
(declare-fun cast-from-Int-to-var931 (Int) var931)
(declare-const null-var3116 var3116)
(declare-const null-String String)
(declare-const null-var26 var26)
(declare-const null-var93 var93)
(declare-const var3082 var3116) ; Statement: r1 := @parameter0: org.antlr.v4.tool.Attribute 
(assert (not (= var3082 null-var3116)))
(declare-const var3155 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var3155 null-String)))
(declare-const var109 var26) ; Statement: r12 := @parameter2: org.antlr.v4.tool.ast.ActionAST 
(assert (not (= var109 null-var26)))
(declare-const var2483 var93) ; Statement: r10 := @parameter3: org.antlr.v4.tool.Grammar 
(assert (not (= var2483 null-var93)))
(define-const var1775 Int (cast-from-Int-to-Int -1)) ; Statement: $i14 = (int) -1 
(define-const var3713 Int var1775) ; Statement: i6 = $i14 
(define-const var3404 Int (cast-from-Int-to-Int -1)) ; Statement: $i16 = (int) -1 
(define-const var148 Int var3404) ; Statement: i7 = $i16 
(assert true)
(define-const var1588 Int (indexOf/-1037706067 var3155 58)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(58) 
(define-const var1730 Int (cast-from-Int-to-Int -1)) ; Statement: $i18 = (int) -1 
 ; Statement: if i0 != $i18 goto $i8 = i0 
(assert (not (not (= var1588 var1730)))) ; Negate: Cond: i0 != $i18  
(assert true)
(define-const var0 Int (length/-134980193 var3155)) ; Statement: $i8 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: goto [?= i1 = $i8] 
(assert true) ; Non Conditional
(define-const var2712 Int var0) ; Statement: i1 = $i8 
(define-const var492 Int 0) ; Statement: i9 = 0 
(assert true) ; Non Conditional
 ; Statement: if i9 >= i1 goto $i21 = (int) -1 
(assert (>= var492 var2712)) ; Cond: i9 >= i1 
(define-const var3428 Int (cast-from-Int-to-Int -1)) ; Statement: $i21 = (int) -1 
 ; Statement: if i6 != $i21 goto i11 = i6 
(assert (not (= var3713 var3428))) ; Cond: i6 != $i21 
(define-const var893 Int var3713) ; Statement: i11 = i6 
(assert true) ; Non Conditional
 ; Statement: if i11 >= i1 goto $i24 = (int) -1 
(assert (>= var893 var2712)) ; Cond: i11 >= i1 
(define-const var1071 Int (cast-from-Int-to-Int -1)) ; Statement: $i24 = (int) -1 
 ; Statement: if i7 != $i24 goto $r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i6, i7) 
(assert (not (= var148 var1071))) ; Cond: i7 != $i24 
(assert (not (and true (and (>= var3713 0) (>= (str.len var3155) var148) (>= var148 var3713)))))
(check-sat)
; {cast-from-Int-to-Int=([int], int), indexOf/-1037706067=([java.lang.String, int], int), length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), name/-785846261=([org.antlr.v4.tool.Attribute], java.lang.String), type/-785846261=([org.antlr.v4.tool.Attribute], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String), var1603-init=([], org.antlr.v4.runtime.misc.Pair), Int_valueOf/-1371140006=([int], java.lang.Integer), <init>/1587308532=([org.antlr.v4.runtime.misc.Pair, java.lang.Object, java.lang.Object], void), cast-from-Int-to-var931=([java.lang.Integer], java.lang.Object)}
; {var3116=org.antlr.v4.tool.Attribute, var3082=r1, var3155=r0, var212=null_type, var26=org.antlr.v4.tool.ast.ActionAST, var109=r12, var93=org.antlr.v4.tool.Grammar, var2483=r10, var1775=$i14, var3713=i6, var3404=$i16, var148=i7, var1588=i0, var1730=$i18, var0=$i8, var2712=i1, var492=i9, var3428=$i21, var893=i11, var1071=$i24, var665=$r2, var3703=$i26, var2274=$r4, var3470=$r5, var2301=$r6, var1092=$i4, var1603=org.antlr.v4.runtime.misc.Pair, var950=$r18, var2368=$r9, var3982=$r8, var931=java.lang.Object}
; {org.antlr.v4.tool.Attribute=var3116, r1=var3082, r0=var3155, null_type=var212, org.antlr.v4.tool.ast.ActionAST=var26, r12=var109, org.antlr.v4.tool.Grammar=var93, r10=var2483, $i14=var1775, i6=var3713, $i16=var3404, i7=var148, i0=var1588, $i18=var1730, $i8=var0, i1=var2712, i9=var492, $i21=var3428, i11=var893, $i24=var1071, $r2=var665, $i26=var3703, $r4=var2274, $r5=var3470, $r6=var2301, $i4=var1092, org.antlr.v4.runtime.misc.Pair=var1603, $r18=var950, $r9=var2368, $r8=var3982, java.lang.Object=var931}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String trim()>;	<java.lang.String: int length()>
;cnt {"<java.lang.String: int indexOf(int)>": 1,"<java.lang.String: int length()>": 2,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String trim()>": 1}
;stmts r1 := @parameter0: org.antlr.v4.tool.Attribute;	r0 := @parameter1: java.lang.String;	r12 := @parameter2: org.antlr.v4.tool.ast.ActionAST;	r10 := @parameter3: org.antlr.v4.tool.Grammar;	$i14 = (int) -1;	i6 = $i14;	$i16 = (int) -1;	i7 = $i16;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(58);	$i18 = (int) -1;	if i0 != $i18 goto $i8 = i0;	$i8 = virtualinvoke r0.<java.lang.String: int length()>();	goto [?= i1 = $i8];	i1 = $i8;	i9 = 0;	if i9 >= i1 goto $i21 = (int) -1;	$i21 = (int) -1;	if i6 != $i21 goto i11 = i6;	i11 = i6;	if i11 >= i1 goto $i24 = (int) -1;	$i24 = (int) -1;	if i7 != $i24 goto $r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i6, i7);	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i6, i7);	r1.<org.antlr.v4.tool.Attribute: java.lang.String name> = $r2;	$i26 = (int) -1;	if i0 != $i26 goto $i3 = i0 + 1;	r1.<org.antlr.v4.tool.Attribute: java.lang.String type> = "";	goto [?= $r4 = r1.<org.antlr.v4.tool.Attribute: java.lang.String type>];	$r4 = r1.<org.antlr.v4.tool.Attribute: java.lang.String type>;	$r5 = virtualinvoke $r4.<java.lang.String: java.lang.String trim()>();	r1.<org.antlr.v4.tool.Attribute: java.lang.String type> = $r5;	$r6 = r1.<org.antlr.v4.tool.Attribute: java.lang.String type>;	$i4 = virtualinvoke $r6.<java.lang.String: int length()>();	if $i4 != 0 goto $r18 = new org.antlr.v4.runtime.misc.Pair;	$r18 = new org.antlr.v4.runtime.misc.Pair;	$r9 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i6);	$r8 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i7);	specialinvoke $r18.<org.antlr.v4.runtime.misc.Pair: void <init>(java.lang.Object,java.lang.Object)>($r9, $r8);	return $r18
;block_num 12
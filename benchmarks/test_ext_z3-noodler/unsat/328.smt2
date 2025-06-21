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

(declare-sort var186 0)
(declare-sort var3362 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun arr-var3362-init () (Array Int var3362))
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var3362 (Int) var3362)
(declare-fun String_format/1339386452 (String (Array Int var3362)) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-__Array__Int__var3362__ (Array Int var3362))
(declare-const var654 String) ; Statement: r1 := @parameter0: java.lang.StringBuilder 
(assert (not (= var654 null-String)))
(declare-const var363 Int) ; Statement: i1 := @parameter1: int 
(assert (not (= var363 null-Int)))
(declare-const var2795 String) ; Statement: r0 := @parameter2: java.lang.String 
(assert (not (= var2795 null-String)))
(define-const var3770 Int -1) ; Statement: b4 = -1 
(assert true)
(define-const var1223 Int (hashCode/-467973558 var2795)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int hashCode()>() 
 ; Statement: lookupswitch($i0) {     case 2312: goto $z11 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("Go");     case 67971: goto $z10 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("Cpp");     case 79192: goto $z9 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("PHP");     case 2122655: goto $z8 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("Dart");     case 2301506: goto $z7 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("Java");     case 80301555: goto $z6 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("Swift");     case 555046085: goto $z5 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("TypeScript");     case 1266327981: goto $z4 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("JavaScript");     case 1560314551: goto $z3 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("Python3");     case 1998000487: goto $z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("CSharp");     default: goto tableswitch(b4) {     case 0: goto $z1 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 1: goto $z1 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 2: goto $z1 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 3: goto $z1 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 4: goto $z1 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 5: goto $r2 = newarray (java.lang.Object)[1];     case 6: goto $z2 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 7: goto $z2 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 8: goto $z2 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 9: goto $z2 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     default: goto $z2 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1); }; } 
(assert (and (not (= var1223 1998000487)) (and (not (= var1223 1560314551)) (and (not (= var1223 1266327981)) (and (not (= var1223 555046085)) (and (not (= var1223 80301555)) (and (not (= var1223 2301506)) (and (not (= var1223 2122655)) (and (not (= var1223 79192)) (and (not (= var1223 67971)) (and (not (= var1223 2312)) true))))))))))) ; Intersect: Negate: Cond: $i0 == 1998000487   and Intersect: Negate: Cond: $i0 == 1560314551   and Intersect: Negate: Cond: $i0 == 1266327981   and Intersect: Negate: Cond: $i0 == 555046085   and Intersect: Negate: Cond: $i0 == 80301555   and Intersect: Negate: Cond: $i0 == 2301506   and Intersect: Negate: Cond: $i0 == 2122655   and Intersect: Negate: Cond: $i0 == 79192   and Intersect: Negate: Cond: $i0 == 67971   and Intersect: Negate: Cond: $i0 == 2312   and Non Conditional          
 ; Statement: tableswitch(b4) {     case 0: goto $z1 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 1: goto $z1 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 2: goto $z1 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 3: goto $z1 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 4: goto $z1 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 5: goto $r2 = newarray (java.lang.Object)[1];     case 6: goto $z2 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 7: goto $z2 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 8: goto $z2 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 9: goto $z2 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     default: goto $z2 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1); } 
(assert (and (= var3770 5) (and (not (= var3770 4)) (and (not (= var3770 3)) (and (not (= var3770 2)) (and (not (= var3770 1)) (and (not (= var3770 0)) true))))))) ; Intersect: Cond: b4 == 5  and Intersect: Negate: Cond: b4 == 4   and Intersect: Negate: Cond: b4 == 3   and Intersect: Negate: Cond: b4 == 2   and Intersect: Negate: Cond: b4 == 1   and Intersect: Negate: Cond: b4 == 0   and Non Conditional      
(define-const var2201 (Array Int var3362) arr-var3362-init) ; Statement: $r2 = newarray (java.lang.Object)[1] 
(define-const var1762 Int (Int_valueOf/-1371140006 var363)) ; Statement: $r3 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i1) 
(declare-const var2201!1 (Array Int var3362))
(assert (not (= var2201!1 null-__Array__Int__var3362__)))
(assert (= (select var2201!1 0) (cast-from-Int-to-var3362 var1762))) ; Statement: $r2[0] = $r3 
(define-const var3252 String (String_format/1339386452 "\u005cu{%04X}" var2201!1)) ; Statement: $r4 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("\\u{%04X}", $r2) 
(assert true)
;(assert (append/672562846 var654 var3252)) ; Statement: virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var654!1 String)
(assert (= var654!1 (str.++ var654 var3252)))
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {hashCode/-467973558=([java.lang.String], int), arr-var3362-init=([], java.lang.Object[]), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var3362=([java.lang.Integer], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder)}
; {var654=r1, var363=i1, var2795=r0, var186=null_type, var3770=b4, var1223=$i0, var3362=java.lang.Object, var2201=$r2, var1762=$r3, var3252=$r4}
; {r1=var654, i1=var363, r0=var2795, null_type=var186, b4=var3770, $i0=var1223, java.lang.Object=var3362, $r2=var2201, $r3=var1762, $r4=var3252}
;seq <java.lang.String: int hashCode()>;	<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.String: int hashCode()>": 1,"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1}
;stmts r1 := @parameter0: java.lang.StringBuilder;	i1 := @parameter1: int;	r0 := @parameter2: java.lang.String;	b4 = -1;	$i0 = virtualinvoke r0.<java.lang.String: int hashCode()>();	lookupswitch($i0) {     case 2312: goto $z11 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("Go");     case 67971: goto $z10 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("Cpp");     case 79192: goto $z9 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("PHP");     case 2122655: goto $z8 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("Dart");     case 2301506: goto $z7 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("Java");     case 80301555: goto $z6 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("Swift");     case 555046085: goto $z5 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("TypeScript");     case 1266327981: goto $z4 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("JavaScript");     case 1560314551: goto $z3 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("Python3");     case 1998000487: goto $z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>("CSharp");     default: goto tableswitch(b4) {     case 0: goto $z1 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 1: goto $z1 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 2: goto $z1 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 3: goto $z1 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 4: goto $z1 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 5: goto $r2 = newarray (java.lang.Object)[1];     case 6: goto $z2 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 7: goto $z2 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 8: goto $z2 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 9: goto $z2 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     default: goto $z2 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1); }; };	tableswitch(b4) {     case 0: goto $z1 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 1: goto $z1 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 2: goto $z1 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 3: goto $z1 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 4: goto $z1 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 5: goto $r2 = newarray (java.lang.Object)[1];     case 6: goto $z2 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 7: goto $z2 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 8: goto $z2 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     case 9: goto $z2 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1);     default: goto $z2 = staticinvoke <java.lang.Character: boolean isSupplementaryCodePoint(int)>(i1); };	$r2 = newarray (java.lang.Object)[1];	$r3 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i1);	$r2[0] = $r3;	$r4 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("\\u{%04X}", $r2);	virtualinvoke r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	goto [?= return];	return
;block_num 4
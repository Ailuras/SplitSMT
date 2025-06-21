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

(declare-sort var2570 0)
(declare-sort var1589 0)
(declare-sort var1263 0)
(declare-sort var1141 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var1589-init () (Array Int var1589))
(declare-fun toString/-522406933 (var1589) String)
(declare-fun cast-from-var2570-to-var1589 (var2570) var1589)
(declare-fun cast-from-String-to-var1589 (String) var1589)
(declare-fun type/-344042480 (var2570) var1263)
(declare-fun cast-from-var1263-to-var1589 (var1263) var1589)
(declare-fun codePoint/-344042480 (var2570) Int)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var1589 (Int) var1589)
(declare-fun propertyIntervalSet/-344042480 (var2570) var1141)
(declare-fun cast-from-var1141-to-var1589 (var1141) var1589)
(declare-fun parseLength/-344042480 (var2570) Int)
(declare-fun String_format/1339386452 (String (Array Int var1589)) String)
(declare-const null-var2570 var2570)
(declare-const null-__Array__Int__var1589__ (Array Int var1589))
(declare-const var148 var2570) ; Statement: r1 := @this: org.antlr.v4.misc.EscapeSequenceParsing$Result 
(assert (not (= var148 null-var2570)))
(define-const var3083 (Array Int var1589) arr-var1589-init) ; Statement: $r0 = newarray (java.lang.Object)[5] 
(assert true)
(define-const var362 String (toString/-522406933 (cast-from-var2570-to-var1589 var148))) ; Statement: $r2 = specialinvoke r1.<java.lang.Object: java.lang.String toString()>() 
(declare-const var3083!1 (Array Int var1589))
(assert (not (= var3083!1 null-__Array__Int__var1589__)))
(assert (= (select var3083!1 0) (cast-from-String-to-var1589 var362))) ; Statement: $r0[0] = $r2 
(define-const var3736 var1263 (type/-344042480 var148)) ; Statement: $r3 = r1.<org.antlr.v4.misc.EscapeSequenceParsing$Result: org.antlr.v4.misc.EscapeSequenceParsing$Result$Type type> 
(declare-const var3083!2 (Array Int var1589))
(assert (not (= var3083!2 null-__Array__Int__var1589__)))
(assert (= (select var3083!2 1) (cast-from-var1263-to-var1589 var3736))) ; Statement: $r0[1] = $r3 
(define-const var92 Int (codePoint/-344042480 var148)) ; Statement: $i0 = r1.<org.antlr.v4.misc.EscapeSequenceParsing$Result: int codePoint> 
(define-const var3393 Int (Int_valueOf/-1371140006 var92)) ; Statement: $r4 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i0) 
(declare-const var3083!3 (Array Int var1589))
(assert (not (= var3083!3 null-__Array__Int__var1589__)))
(assert (= (select var3083!3 2) (cast-from-Int-to-var1589 var3393))) ; Statement: $r0[2] = $r4 
(define-const var1137 var1141 (propertyIntervalSet/-344042480 var148)) ; Statement: $r5 = r1.<org.antlr.v4.misc.EscapeSequenceParsing$Result: org.antlr.v4.runtime.misc.IntervalSet propertyIntervalSet> 
(declare-const var3083!4 (Array Int var1589))
(assert (not (= var3083!4 null-__Array__Int__var1589__)))
(assert (= (select var3083!4 3) (cast-from-var1141-to-var1589 var1137))) ; Statement: $r0[3] = $r5 
(define-const var3644 Int (parseLength/-344042480 var148)) ; Statement: $i1 = r1.<org.antlr.v4.misc.EscapeSequenceParsing$Result: int parseLength> 
(define-const var675 Int (Int_valueOf/-1371140006 var3644)) ; Statement: $r6 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i1) 
(declare-const var3083!5 (Array Int var1589))
(assert (not (= var3083!5 null-__Array__Int__var1589__)))
(assert (= (select var3083!5 4) (cast-from-Int-to-var1589 var675))) ; Statement: $r0[4] = $r6 
(define-const var715 String (String_format/1339386452 "%s type=%s codePoint=%d propertyIntervalSet=%s parseLength=%d" var3083!5)) ; Statement: $r7 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("%s type=%s codePoint=%d propertyIntervalSet=%s parseLength=%d", $r0) 
 ; Statement: return $r7 
(check-sat)
; {arr-var1589-init=([], java.lang.Object[]), toString/-522406933=([java.lang.Object], java.lang.String), cast-from-var2570-to-var1589=([org.antlr.v4.misc.EscapeSequenceParsing$Result], java.lang.Object), cast-from-String-to-var1589=([java.lang.String], java.lang.Object), type/-344042480=([org.antlr.v4.misc.EscapeSequenceParsing$Result], org.antlr.v4.misc.EscapeSequenceParsing$Result$Type), cast-from-var1263-to-var1589=([org.antlr.v4.misc.EscapeSequenceParsing$Result$Type], java.lang.Object), codePoint/-344042480=([org.antlr.v4.misc.EscapeSequenceParsing$Result], int), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var1589=([java.lang.Integer], java.lang.Object), propertyIntervalSet/-344042480=([org.antlr.v4.misc.EscapeSequenceParsing$Result], org.antlr.v4.runtime.misc.IntervalSet), cast-from-var1141-to-var1589=([org.antlr.v4.runtime.misc.IntervalSet], java.lang.Object), parseLength/-344042480=([org.antlr.v4.misc.EscapeSequenceParsing$Result], int), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var2570=org.antlr.v4.misc.EscapeSequenceParsing$Result, var148=r1, var1589=java.lang.Object, var3083=$r0, var362=$r2, var1263=org.antlr.v4.misc.EscapeSequenceParsing$Result$Type, var3736=$r3, var92=$i0, var3393=$r4, var1141=org.antlr.v4.runtime.misc.IntervalSet, var1137=$r5, var3644=$i1, var675=$r6, var715=$r7}
; {org.antlr.v4.misc.EscapeSequenceParsing$Result=var2570, r1=var148, java.lang.Object=var1589, $r0=var3083, $r2=var362, org.antlr.v4.misc.EscapeSequenceParsing$Result$Type=var1263, $r3=var3736, $i0=var92, $r4=var3393, org.antlr.v4.runtime.misc.IntervalSet=var1141, $r5=var1137, $i1=var3644, $r6=var675, $r7=var715}
;seq <java.lang.Object: java.lang.String toString()>;	<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r1 := @this: org.antlr.v4.misc.EscapeSequenceParsing$Result;	$r0 = newarray (java.lang.Object)[5];	$r2 = specialinvoke r1.<java.lang.Object: java.lang.String toString()>();	$r0[0] = $r2;	$r3 = r1.<org.antlr.v4.misc.EscapeSequenceParsing$Result: org.antlr.v4.misc.EscapeSequenceParsing$Result$Type type>;	$r0[1] = $r3;	$i0 = r1.<org.antlr.v4.misc.EscapeSequenceParsing$Result: int codePoint>;	$r4 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i0);	$r0[2] = $r4;	$r5 = r1.<org.antlr.v4.misc.EscapeSequenceParsing$Result: org.antlr.v4.runtime.misc.IntervalSet propertyIntervalSet>;	$r0[3] = $r5;	$i1 = r1.<org.antlr.v4.misc.EscapeSequenceParsing$Result: int parseLength>;	$r6 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i1);	$r0[4] = $r6;	$r7 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("%s type=%s codePoint=%d propertyIntervalSet=%s parseLength=%d", $r0);	return $r7
;block_num 1
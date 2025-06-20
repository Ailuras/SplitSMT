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

(declare-sort var898 0)
(declare-sort var1258 0)
(declare-sort var2655 0)
(declare-sort var3459 0)
(declare-sort var448 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var1258-init () (Array Int var1258))
(declare-fun toString/-522406933 (var1258) String)
(declare-fun cast-from-var898-to-var1258 (var898) var1258)
(declare-fun cast-from-String-to-var1258 (String) var1258)
(declare-fun mode/1638333704 (var898) var2655)
(declare-fun cast-from-var2655-to-var1258 (var2655) var1258)
(declare-fun inRange/1638333704 (var898) Bool)
(declare-fun var3459_valueOf/1602327315 (Bool) var3459)
(declare-fun cast-from-var3459-to-var1258 (var3459) var1258)
(declare-fun prevCodePoint/1638333704 (var898) Int)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var1258 (Int) var1258)
(declare-fun prevProperty/1638333704 (var898) var448)
(declare-fun cast-from-var448-to-var1258 (var448) var1258)
(declare-fun String_format/1339386452 (String (Array Int var1258)) String)
(declare-const null-var898 var898)
(declare-const null-__Array__Int__var1258__ (Array Int var1258))
(declare-const var180 var898) ; Statement: r1 := @this: org.antlr.v4.automata.LexerATNFactory$CharSetParseState 
(assert (not (= var180 null-var898)))
(define-const var3448 (Array Int var1258) arr-var1258-init) ; Statement: $r0 = newarray (java.lang.Object)[5] 
(assert true)
(define-const var1465 String (toString/-522406933 (cast-from-var898-to-var1258 var180))) ; Statement: $r2 = specialinvoke r1.<java.lang.Object: java.lang.String toString()>() 
(declare-const var3448!1 (Array Int var1258))
(assert (not (= var3448!1 null-__Array__Int__var1258__)))
(assert (= (select var3448!1 0) (cast-from-String-to-var1258 var1465))) ; Statement: $r0[0] = $r2 
(define-const var1366 var2655 (mode/1638333704 var180)) ; Statement: $r3 = r1.<org.antlr.v4.automata.LexerATNFactory$CharSetParseState: org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode mode> 
(declare-const var3448!2 (Array Int var1258))
(assert (not (= var3448!2 null-__Array__Int__var1258__)))
(assert (= (select var3448!2 1) (cast-from-var2655-to-var1258 var1366))) ; Statement: $r0[1] = $r3 
(define-const var487 Bool (inRange/1638333704 var180)) ; Statement: $z0 = r1.<org.antlr.v4.automata.LexerATNFactory$CharSetParseState: boolean inRange> 
(define-const var2174 var3459 (var3459_valueOf/1602327315 var487)) ; Statement: $r4 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>($z0) 
(declare-const var3448!3 (Array Int var1258))
(assert (not (= var3448!3 null-__Array__Int__var1258__)))
(assert (= (select var3448!3 2) (cast-from-var3459-to-var1258 var2174))) ; Statement: $r0[2] = $r4 
(define-const var301 Int (prevCodePoint/1638333704 var180)) ; Statement: $i0 = r1.<org.antlr.v4.automata.LexerATNFactory$CharSetParseState: int prevCodePoint> 
(define-const var584 Int (Int_valueOf/-1371140006 var301)) ; Statement: $r5 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i0) 
(declare-const var3448!4 (Array Int var1258))
(assert (not (= var3448!4 null-__Array__Int__var1258__)))
(assert (= (select var3448!4 3) (cast-from-Int-to-var1258 var584))) ; Statement: $r0[3] = $r5 
(define-const var496 var448 (prevProperty/1638333704 var180)) ; Statement: $r6 = r1.<org.antlr.v4.automata.LexerATNFactory$CharSetParseState: org.antlr.v4.runtime.misc.IntervalSet prevProperty> 
(declare-const var3448!5 (Array Int var1258))
(assert (not (= var3448!5 null-__Array__Int__var1258__)))
(assert (= (select var3448!5 4) (cast-from-var448-to-var1258 var496))) ; Statement: $r0[4] = $r6 
(define-const var2038 String (String_format/1339386452 "%s mode=%s inRange=%s prevCodePoint=%d prevProperty=%s" var3448!5)) ; Statement: $r7 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("%s mode=%s inRange=%s prevCodePoint=%d prevProperty=%s", $r0) 
 ; Statement: return $r7 
(check-sat)
; {arr-var1258-init=([], java.lang.Object[]), toString/-522406933=([java.lang.Object], java.lang.String), cast-from-var898-to-var1258=([org.antlr.v4.automata.LexerATNFactory$CharSetParseState], java.lang.Object), cast-from-String-to-var1258=([java.lang.String], java.lang.Object), mode/1638333704=([org.antlr.v4.automata.LexerATNFactory$CharSetParseState], org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode), cast-from-var2655-to-var1258=([org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode], java.lang.Object), inRange/1638333704=([org.antlr.v4.automata.LexerATNFactory$CharSetParseState], boolean), var3459_valueOf/1602327315=([boolean], java.lang.Boolean), cast-from-var3459-to-var1258=([java.lang.Boolean], java.lang.Object), prevCodePoint/1638333704=([org.antlr.v4.automata.LexerATNFactory$CharSetParseState], int), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var1258=([java.lang.Integer], java.lang.Object), prevProperty/1638333704=([org.antlr.v4.automata.LexerATNFactory$CharSetParseState], org.antlr.v4.runtime.misc.IntervalSet), cast-from-var448-to-var1258=([org.antlr.v4.runtime.misc.IntervalSet], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var898=org.antlr.v4.automata.LexerATNFactory$CharSetParseState, var180=r1, var1258=java.lang.Object, var3448=$r0, var1465=$r2, var2655=org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode, var1366=$r3, var487=$z0, var3459=java.lang.Boolean, var2174=$r4, var301=$i0, var584=$r5, var448=org.antlr.v4.runtime.misc.IntervalSet, var496=$r6, var2038=$r7}
; {org.antlr.v4.automata.LexerATNFactory$CharSetParseState=var898, r1=var180, java.lang.Object=var1258, $r0=var3448, $r2=var1465, org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode=var2655, $r3=var1366, $z0=var487, java.lang.Boolean=var3459, $r4=var2174, $i0=var301, $r5=var584, org.antlr.v4.runtime.misc.IntervalSet=var448, $r6=var496, $r7=var2038}
;seq <java.lang.Object: java.lang.String toString()>;	<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r1 := @this: org.antlr.v4.automata.LexerATNFactory$CharSetParseState;	$r0 = newarray (java.lang.Object)[5];	$r2 = specialinvoke r1.<java.lang.Object: java.lang.String toString()>();	$r0[0] = $r2;	$r3 = r1.<org.antlr.v4.automata.LexerATNFactory$CharSetParseState: org.antlr.v4.automata.LexerATNFactory$CharSetParseState$Mode mode>;	$r0[1] = $r3;	$z0 = r1.<org.antlr.v4.automata.LexerATNFactory$CharSetParseState: boolean inRange>;	$r4 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>($z0);	$r0[2] = $r4;	$i0 = r1.<org.antlr.v4.automata.LexerATNFactory$CharSetParseState: int prevCodePoint>;	$r5 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i0);	$r0[3] = $r5;	$r6 = r1.<org.antlr.v4.automata.LexerATNFactory$CharSetParseState: org.antlr.v4.runtime.misc.IntervalSet prevProperty>;	$r0[4] = $r6;	$r7 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("%s mode=%s inRange=%s prevCodePoint=%d prevProperty=%s", $r0);	return $r7
;block_num 1
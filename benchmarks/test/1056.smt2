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

(declare-sort var2259 0)
(declare-sort var2992 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var2992-init () (Array Int var2992))
(declare-fun cast-from-String-to-var2992 (String) var2992)
(declare-fun String_format/1339386452 (String (Array Int var2992)) String)
(declare-const null-String String)
(declare-const null-__Array__Int__var2992__ (Array Int var2992))
(declare-const var1124 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1124 null-String)))
(declare-const var204 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var204 null-String)))
(declare-const var1036 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var1036 null-String)))
(declare-const var2646 String) ; Statement: r4 := @parameter3: java.lang.String 
(assert (not (= var2646 null-String)))
(define-const var1685 (Array Int var2992) arr-var2992-init) ; Statement: $r0 = newarray (java.lang.Object)[4] 
(declare-const var1685!1 (Array Int var2992))
(assert (not (= var1685!1 null-__Array__Int__var2992__)))
(assert (= (select var1685!1 0) (cast-from-String-to-var2992 var1124))) ; Statement: $r0[0] = r1 
(declare-const var1685!2 (Array Int var2992))
(assert (not (= var1685!2 null-__Array__Int__var2992__)))
(assert (= (select var1685!2 1) (cast-from-String-to-var2992 var204))) ; Statement: $r0[1] = r2 
(declare-const var1685!3 (Array Int var2992))
(assert (not (= var1685!3 null-__Array__Int__var2992__)))
(assert (= (select var1685!3 2) (cast-from-String-to-var2992 var1036))) ; Statement: $r0[2] = r3 
(declare-const var1685!4 (Array Int var2992))
(assert (not (= var1685!4 null-__Array__Int__var2992__)))
(assert (= (select var1685!4 3) (cast-from-String-to-var2992 var2646))) ; Statement: $r0[3] = r4 
(define-const var495 String (String_format/1339386452 "<text x=\u0022%s\u0022 y=\u0022%s\u0022 style=\u0022%s\u0022>\n%s\n</text>\n" var1685!4)) ; Statement: $r5 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("<text x=\"%s\" y=\"%s\" style=\"%s\">\n%s\n</text>\n", $r0) 
 ; Statement: return $r5 
(check-sat)
; {arr-var2992-init=([], java.lang.Object[]), cast-from-String-to-var2992=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var1124=r1, var2259=null_type, var204=r2, var1036=r3, var2646=r4, var2992=java.lang.Object, var1685=$r0, var495=$r5}
; {r1=var1124, null_type=var2259, r2=var204, r3=var1036, r4=var2646, java.lang.Object=var2992, $r0=var1685, $r5=var495}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	r4 := @parameter3: java.lang.String;	$r0 = newarray (java.lang.Object)[4];	$r0[0] = r1;	$r0[1] = r2;	$r0[2] = r3;	$r0[3] = r4;	$r5 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("<text x=\"%s\" y=\"%s\" style=\"%s\">\n%s\n</text>\n", $r0);	return $r5
;block_num 1
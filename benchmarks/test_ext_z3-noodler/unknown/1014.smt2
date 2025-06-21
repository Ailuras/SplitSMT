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

(declare-sort var2368 0)
(declare-sort var3901 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var3901-init () (Array Int var3901))
(declare-fun cast-from-String-to-var3901 (String) var3901)
(declare-fun String_format/1339386452 (String (Array Int var3901)) String)
(declare-const null-String String)
(declare-const null-__Array__Int__var3901__ (Array Int var3901))
(declare-const var3406 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3406 null-String)))
(declare-const var2125 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2125 null-String)))
(declare-const var477 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var477 null-String)))
(declare-const var2563 String) ; Statement: r4 := @parameter3: java.lang.String 
(assert (not (= var2563 null-String)))
(declare-const var475 String) ; Statement: r5 := @parameter4: java.lang.String 
(assert (not (= var475 null-String)))
(declare-const var335 String) ; Statement: r6 := @parameter5: java.lang.String 
(assert (not (= var335 null-String)))
(define-const var960 (Array Int var3901) arr-var3901-init) ; Statement: $r0 = newarray (java.lang.Object)[6] 
(declare-const var960!1 (Array Int var3901))
(assert (not (= var960!1 null-__Array__Int__var3901__)))
(assert (= (select var960!1 0) (cast-from-String-to-var3901 var3406))) ; Statement: $r0[0] = r1 
(declare-const var960!2 (Array Int var3901))
(assert (not (= var960!2 null-__Array__Int__var3901__)))
(assert (= (select var960!2 1) (cast-from-String-to-var3901 var2125))) ; Statement: $r0[1] = r2 
(declare-const var960!3 (Array Int var3901))
(assert (not (= var960!3 null-__Array__Int__var3901__)))
(assert (= (select var960!3 2) (cast-from-String-to-var3901 var477))) ; Statement: $r0[2] = r3 
(declare-const var960!4 (Array Int var3901))
(assert (not (= var960!4 null-__Array__Int__var3901__)))
(assert (= (select var960!4 3) (cast-from-String-to-var3901 var2563))) ; Statement: $r0[3] = r4 
(declare-const var960!5 (Array Int var3901))
(assert (not (= var960!5 null-__Array__Int__var3901__)))
(assert (= (select var960!5 4) (cast-from-String-to-var3901 var475))) ; Statement: $r0[4] = r5 
(declare-const var960!6 (Array Int var3901))
(assert (not (= var960!6 null-__Array__Int__var3901__)))
(assert (= (select var960!6 5) (cast-from-String-to-var3901 var335))) ; Statement: $r0[5] = r6 
(define-const var2342 String (String_format/1339386452 "<rect x=\u0022%s\u0022 y=\u0022%s\u0022 width=\u0022%s\u0022 height=\u0022%s\u0022 style=\u0022%s\u0022 %s/>\n" var960!6)) ; Statement: $r7 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("<rect x=\"%s\" y=\"%s\" width=\"%s\" height=\"%s\" style=\"%s\" %s/>\n", $r0) 
 ; Statement: return $r7 
(check-sat)
; {arr-var3901-init=([], java.lang.Object[]), cast-from-String-to-var3901=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var3406=r1, var2368=null_type, var2125=r2, var477=r3, var2563=r4, var475=r5, var335=r6, var3901=java.lang.Object, var960=$r0, var2342=$r7}
; {r1=var3406, null_type=var2368, r2=var2125, r3=var477, r4=var2563, r5=var475, r6=var335, java.lang.Object=var3901, $r0=var960, $r7=var2342}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	r4 := @parameter3: java.lang.String;	r5 := @parameter4: java.lang.String;	r6 := @parameter5: java.lang.String;	$r0 = newarray (java.lang.Object)[6];	$r0[0] = r1;	$r0[1] = r2;	$r0[2] = r3;	$r0[3] = r4;	$r0[4] = r5;	$r0[5] = r6;	$r7 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("<rect x=\"%s\" y=\"%s\" width=\"%s\" height=\"%s\" style=\"%s\" %s/>\n", $r0);	return $r7
;block_num 1
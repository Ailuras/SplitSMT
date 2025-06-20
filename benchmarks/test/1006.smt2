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

(declare-sort var2365 0)
(declare-sort var3798 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var3798-init () (Array Int var3798))
(declare-fun cast-from-String-to-var3798 (String) var3798)
(declare-fun String_format/1339386452 (String (Array Int var3798)) String)
(declare-const null-String String)
(declare-const null-__Array__Int__var3798__ (Array Int var3798))
(declare-const var2972 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2972 null-String)))
(declare-const var2655 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2655 null-String)))
(declare-const var1606 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var1606 null-String)))
(declare-const var390 String) ; Statement: r4 := @parameter3: java.lang.String 
(assert (not (= var390 null-String)))
(declare-const var988 String) ; Statement: r5 := @parameter4: java.lang.String 
(assert (not (= var988 null-String)))
(define-const var511 (Array Int var3798) arr-var3798-init) ; Statement: $r0 = newarray (java.lang.Object)[5] 
(declare-const var511!1 (Array Int var3798))
(assert (not (= var511!1 null-__Array__Int__var3798__)))
(assert (= (select var511!1 0) (cast-from-String-to-var3798 var2972))) ; Statement: $r0[0] = r1 
(declare-const var511!2 (Array Int var3798))
(assert (not (= var511!2 null-__Array__Int__var3798__)))
(assert (= (select var511!2 1) (cast-from-String-to-var3798 var2655))) ; Statement: $r0[1] = r2 
(declare-const var511!3 (Array Int var3798))
(assert (not (= var511!3 null-__Array__Int__var3798__)))
(assert (= (select var511!3 2) (cast-from-String-to-var3798 var1606))) ; Statement: $r0[2] = r3 
(declare-const var511!4 (Array Int var3798))
(assert (not (= var511!4 null-__Array__Int__var3798__)))
(assert (= (select var511!4 3) (cast-from-String-to-var3798 var390))) ; Statement: $r0[3] = r4 
(declare-const var511!5 (Array Int var3798))
(assert (not (= var511!5 null-__Array__Int__var3798__)))
(assert (= (select var511!5 4) (cast-from-String-to-var3798 var988))) ; Statement: $r0[4] = r5 
(define-const var1897 String (String_format/1339386452 "<line x1=\u0022%s\u0022 y1=\u0022%s\u0022 x2=\u0022%s\u0022 y2=\u0022%s\u0022 style=\u0022%s\u0022 />\n" var511!5)) ; Statement: $r6 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("<line x1=\"%s\" y1=\"%s\" x2=\"%s\" y2=\"%s\" style=\"%s\" />\n", $r0) 
 ; Statement: return $r6 
(check-sat)
; {arr-var3798-init=([], java.lang.Object[]), cast-from-String-to-var3798=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var2972=r1, var2365=null_type, var2655=r2, var1606=r3, var390=r4, var988=r5, var3798=java.lang.Object, var511=$r0, var1897=$r6}
; {r1=var2972, null_type=var2365, r2=var2655, r3=var1606, r4=var390, r5=var988, java.lang.Object=var3798, $r0=var511, $r6=var1897}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	r4 := @parameter3: java.lang.String;	r5 := @parameter4: java.lang.String;	$r0 = newarray (java.lang.Object)[5];	$r0[0] = r1;	$r0[1] = r2;	$r0[2] = r3;	$r0[3] = r4;	$r0[4] = r5;	$r6 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("<line x1=\"%s\" y1=\"%s\" x2=\"%s\" y2=\"%s\" style=\"%s\" />\n", $r0);	return $r6
;block_num 1
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

(declare-sort var1841 0)
(declare-sort var2683 0)
(declare-sort var3994 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-fun arr-var3994-init () (Array Int var3994))
(declare-fun cast-from-String-to-var3994 (String) var3994)
(declare-fun String_format/1339386452 (String (Array Int var3994)) String)
(declare-const null-var1841 var1841)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-Bool Bool)
(declare-const null-String String)
(declare-const null-__Array__Int__var3994__ (Array Int var3994))
(declare-const var2763 var1841) ; Statement: r10 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator 
(assert (not (= var2763 null-var1841)))
(declare-const var1126 (Array Int String)) ; Statement: r0 := @parameter0: java.lang.String[] 
(assert (not (= var1126 null-__Array__Int__String__)))
(declare-const var2910 Bool) ; Statement: z1 := @parameter1: boolean 
(assert (not (= var2910 null-Bool)))
(define-const var648 String null-String) ; Statement: r30 = null 
(define-const var1256 Int (getLength-Arr-String-1 var1126)) ; Statement: $i0 = lengthof r0 
(define-const var1889 Int (- var1256 1)) ; Statement: i3 = $i0 - 1 
(assert true) ; Non Conditional
 ; Statement: if i3 < 0 goto $r1 = newarray (java.lang.Object)[1] 
(assert (< var1889 0)) ; Cond: i3 < 0 
(define-const var781 (Array Int var3994) arr-var3994-init) ; Statement: $r1 = newarray (java.lang.Object)[1] 
(declare-const var781!1 (Array Int var3994))
(assert (not (= var781!1 null-__Array__Int__var3994__)))
(assert (= (select var781!1 0) (cast-from-String-to-var3994 var648))) ; Statement: $r1[0] = r30 
(define-const var3025 String (String_format/1339386452 "String extName = %s;\n" var781!1)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("String extName = %s;\n", $r1) 
 ; Statement: return $r2 
(check-sat)
; {getLength-Arr-String-1=([java.lang.String[]], int), arr-var3994-init=([], java.lang.Object[]), cast-from-String-to-var3994=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var1841=org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, var2763=r10, var1126=r0, var2910=z1, var2683=null_type, var648=r30, var1256=$i0, var1889=i3, var3994=java.lang.Object, var781=$r1, var3025=$r2}
; {org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator=var1841, r10=var2763, r0=var1126, z1=var2910, null_type=var2683, r30=var648, $i0=var1256, i3=var1889, java.lang.Object=var3994, $r1=var781, $r2=var3025}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r10 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator;	r0 := @parameter0: java.lang.String[];	z1 := @parameter1: boolean;	r30 = null;	$i0 = lengthof r0;	i3 = $i0 - 1;	if i3 < 0 goto $r1 = newarray (java.lang.Object)[1];	$r1 = newarray (java.lang.Object)[1];	$r1[0] = r30;	$r2 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("String extName = %s;\n", $r1);	return $r2
;block_num 3
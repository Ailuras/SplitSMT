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

(declare-sort var3802 0)
(declare-sort var532 0)
(declare-sort var3834 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun name/-1199450271 (var3802) String)
(declare-fun arr-var3834-init () (Array Int var3834))
(declare-fun cast-from-String-to-var3834 (String) var3834)
(declare-fun String_format/1339386452 (String (Array Int var3834)) String)
(declare-const null-var3802 var3802)
(declare-const null-String String)
(declare-const null-__Array__Int__var3834__ (Array Int var3834))
(declare-const var2781 var3802) ; Statement: r0 := @this: org.apache.dubbo.metrics.model.key.MetricsKey 
(assert (not (= var2781 null-var3802)))
(declare-const var2154 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2154 null-String)))
(define-const var1136 String (name/-1199450271 var2781)) ; Statement: $r3 = r0.<org.apache.dubbo.metrics.model.key.MetricsKey: java.lang.String name> 
(define-const var981 (Array Int var3834) arr-var3834-init) ; Statement: $r1 = newarray (java.lang.Object)[1] 
(declare-const var981!1 (Array Int var3834))
(assert (not (= var981!1 null-__Array__Int__var3834__)))
(assert (= (select var981!1 0) (cast-from-String-to-var3834 var2154))) ; Statement: $r1[0] = r2 
(define-const var2696 String (String_format/1339386452 var1136 var981!1)) ; Statement: $r4 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>($r3, $r1) 
 ; Statement: return $r4 
(check-sat)
; {name/-1199450271=([org.apache.dubbo.metrics.model.key.MetricsKey], java.lang.String), arr-var3834-init=([], java.lang.Object[]), cast-from-String-to-var3834=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var3802=org.apache.dubbo.metrics.model.key.MetricsKey, var2781=r0, var2154=r2, var532=null_type, var1136=$r3, var3834=java.lang.Object, var981=$r1, var2696=$r4}
; {org.apache.dubbo.metrics.model.key.MetricsKey=var3802, r0=var2781, r2=var2154, null_type=var532, $r3=var1136, java.lang.Object=var3834, $r1=var981, $r4=var2696}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r0 := @this: org.apache.dubbo.metrics.model.key.MetricsKey;	r2 := @parameter0: java.lang.String;	$r3 = r0.<org.apache.dubbo.metrics.model.key.MetricsKey: java.lang.String name>;	$r1 = newarray (java.lang.Object)[1];	$r1[0] = r2;	$r4 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>($r3, $r1);	return $r4
;block_num 1
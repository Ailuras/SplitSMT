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

(declare-sort var3620 0)
(declare-sort var2017 0)
(declare-sort var3434 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun name/611032034 (var3620) String)
(declare-fun arr-var3434-init () (Array Int var3434))
(declare-fun cast-from-String-to-var3434 (String) var3434)
(declare-fun String_format/1339386452 (String (Array Int var3434)) String)
(declare-const null-var3620 var3620)
(declare-const null-String String)
(declare-const null-__Array__Int__var3434__ (Array Int var3434))
(declare-const var2797 var3620) ; Statement: r0 := @this: org.apache.dubbo.metrics.event.MetricsEvent$Type 
(assert (not (= var2797 null-var3620)))
(declare-const var3461 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var3461 null-String)))
(define-const var1729 String (name/611032034 var2797)) ; Statement: $r3 = r0.<org.apache.dubbo.metrics.event.MetricsEvent$Type: java.lang.String name> 
(define-const var820 (Array Int var3434) arr-var3434-init) ; Statement: $r1 = newarray (java.lang.Object)[1] 
(declare-const var820!1 (Array Int var3434))
(assert (not (= var820!1 null-__Array__Int__var3434__)))
(assert (= (select var820!1 0) (cast-from-String-to-var3434 var3461))) ; Statement: $r1[0] = r2 
(define-const var2263 String (String_format/1339386452 var1729 var820!1)) ; Statement: $r4 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>($r3, $r1) 
 ; Statement: return $r4 
(check-sat)
; {name/611032034=([org.apache.dubbo.metrics.event.MetricsEvent$Type], java.lang.String), arr-var3434-init=([], java.lang.Object[]), cast-from-String-to-var3434=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String)}
; {var3620=org.apache.dubbo.metrics.event.MetricsEvent$Type, var2797=r0, var3461=r2, var2017=null_type, var1729=$r3, var3434=java.lang.Object, var820=$r1, var2263=$r4}
; {org.apache.dubbo.metrics.event.MetricsEvent$Type=var3620, r0=var2797, r2=var3461, null_type=var2017, $r3=var1729, java.lang.Object=var3434, $r1=var820, $r4=var2263}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r0 := @this: org.apache.dubbo.metrics.event.MetricsEvent$Type;	r2 := @parameter0: java.lang.String;	$r3 = r0.<org.apache.dubbo.metrics.event.MetricsEvent$Type: java.lang.String name>;	$r1 = newarray (java.lang.Object)[1];	$r1[0] = r2;	$r4 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>($r3, $r1);	return $r4
;block_num 1
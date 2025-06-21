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

(declare-sort var2789 0)
(declare-sort var1295 0)
(declare-sort var1290 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun allApplication/1499839782 (var2789 var1290) String)
(declare-const null-var2789 var2789)
(declare-const null-String String)
(declare-const null-var1290 var1290)
(declare-const var3955 var2789) ; Statement: r2 := @this: org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd 
(assert (not (= var3955 null-var2789)))
(declare-const var768 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var768 null-String)))
(declare-const var2523 var1290) ; Statement: r3 := @parameter1: java.util.List 
(assert (not (= var2523 null-var1290)))
(declare-const var2218 String) ; Statement: r4 := @parameter2: java.lang.String 
(assert (not (= var2218 null-String)))
(define-const var1747 String "application_all") ; Statement: $r1 = "application_all" 
(assert true)
(define-const var379 Bool (= var1747 var768)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r5 = specialinvoke r2.<org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd: java.lang.String specifySingleApplication(java.lang.String,java.util.List,java.lang.String)>(r0, r3, r4) 
(assert (not (= (ite var379 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var1066 String (allApplication/1499839782 var3955 var2523)) ; Statement: $r6 = specialinvoke r2.<org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd: java.lang.String allApplication(java.util.List)>(r3) 
 ; Statement: return $r6 
(check-sat)
; {allApplication/1499839782=([org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd, java.util.List], java.lang.String)}
; {var2789=org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd, var3955=r2, var768=r0, var1295=null_type, var1290=java.util.List, var2523=r3, var2218=r4, var1747=$r1, var379=$z0, var1066=$r6}
; {org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd=var2789, r2=var3955, r0=var768, null_type=var1295, java.util.List=var1290, r3=var2523, r4=var2218, $r1=var1747, $z0=var379, $r6=var1066}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r2 := @this: org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd;	r0 := @parameter0: java.lang.String;	r3 := @parameter1: java.util.List;	r4 := @parameter2: java.lang.String;	$r1 = "application_all";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r5 = specialinvoke r2.<org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd: java.lang.String specifySingleApplication(java.lang.String,java.util.List,java.lang.String)>(r0, r3, r4);	$r6 = specialinvoke r2.<org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd: java.lang.String allApplication(java.util.List)>(r3);	return $r6
;block_num 2
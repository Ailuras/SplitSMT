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

(declare-sort var3982 0)
(declare-sort var3081 0)
(declare-sort var886 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun specifySingleApplication/-691372004 (var3982 String var886 String) String)
(declare-const null-var3982 var3982)
(declare-const null-String String)
(declare-const null-var886 var886)
(declare-const var1024 var3982) ; Statement: r2 := @this: org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd 
(assert (not (= var1024 null-var3982)))
(declare-const var2435 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2435 null-String)))
(declare-const var1746 var886) ; Statement: r3 := @parameter1: java.util.List 
(assert (not (= var1746 null-var886)))
(declare-const var3126 String) ; Statement: r4 := @parameter2: java.lang.String 
(assert (not (= var3126 null-String)))
(define-const var2212 String "application_all") ; Statement: $r1 = "application_all" 
(assert true)
(define-const var1148 Bool (= var2212 var2435)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r5 = specialinvoke r2.<org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd: java.lang.String specifySingleApplication(java.lang.String,java.util.List,java.lang.String)>(r0, r3, r4) 
(assert (= (ite var1148 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3518 String (specifySingleApplication/-691372004 var1024 var2435 var1746 var3126)) ; Statement: $r5 = specialinvoke r2.<org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd: java.lang.String specifySingleApplication(java.lang.String,java.util.List,java.lang.String)>(r0, r3, r4) 
 ; Statement: return $r5 
(check-sat)
; {specifySingleApplication/-691372004=([org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd, java.lang.String, java.util.List, java.lang.String], java.lang.String)}
; {var3982=org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd, var1024=r2, var2435=r0, var3081=null_type, var886=java.util.List, var1746=r3, var3126=r4, var2212=$r1, var1148=$z0, var3518=$r5}
; {org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd=var3982, r2=var1024, r0=var2435, null_type=var3081, java.util.List=var886, r3=var1746, r4=var3126, $r1=var2212, $z0=var1148, $r5=var3518}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r2 := @this: org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd;	r0 := @parameter0: java.lang.String;	r3 := @parameter1: java.util.List;	r4 := @parameter2: java.lang.String;	$r1 = "application_all";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r5 = specialinvoke r2.<org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd: java.lang.String specifySingleApplication(java.lang.String,java.util.List,java.lang.String)>(r0, r3, r4);	$r5 = specialinvoke r2.<org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd: java.lang.String specifySingleApplication(java.lang.String,java.util.List,java.lang.String)>(r0, r3, r4);	return $r5
;block_num 2
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

(declare-sort var1149 0)
(declare-sort var2831 0)
(declare-sort var2793 0)
(declare-sort var3145 0)
(declare-sort var1907 0)
(declare-sort var3356 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3145_info/484404803 (var3145 String) void)
(declare-fun cast-from-var2793-to-var3145 (var2793) var3145)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun frameworkModel/1756283506 (var1149) var1907)
(declare-fun getApplicationModels/1555269024 (var1907) var3356)
(declare-fun var3356_iterator/-912451715 (var3356) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1149 var1149)
(declare-const null-var2831 var2831)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1149-logger var2793)
(declare-const var3616 var1149) ; Statement: r2 := @this: org.apache.dubbo.qos.command.impl.PublishMetadata 
(assert (not (= var3616 null-var1149)))
(declare-const var1839 var2831) ; Statement: r29 := @parameter0: org.apache.dubbo.qos.api.CommandContext 
(assert (not (= var1839 null-var2831)))
(declare-const var137 (Array Int String)) ; Statement: r9 := @parameter1: java.lang.String[] 
(assert (not (= var137 null-__Array__Int__String__)))
(define-const var1581 var2793 var1149-logger) ; Statement: $r0 = <org.apache.dubbo.qos.command.impl.PublishMetadata: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var3145_info/484404803 (cast-from-var2793-to-var3145 var1581) "received publishMetadata command.")) ; Statement: interfaceinvoke $r0.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>("received publishMetadata command.") 

(declare-const var1581!1 var2793)
(declare-const var1865 String)
(define-const var1560 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1560)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1560!1 String)
(assert (= var1560!1 ""))
(define-const var964 var1907 (frameworkModel/1756283506 var3616)) ; Statement: $r3 = r2.<org.apache.dubbo.qos.command.impl.PublishMetadata: org.apache.dubbo.rpc.model.FrameworkModel frameworkModel> 
(assert true)
(define-const var2411 var3356 (getApplicationModels/1555269024 var964)) ; Statement: r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.model.FrameworkModel: java.util.List getApplicationModels()>() 
(define-const var1804 Iterator (var3356_iterator/-912451715 var2411)) ; Statement: r5 = interfaceinvoke r4.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var3491 Bool (Iterator_hasNext/-1669924200 var1804)) ; Statement: $z0 = interfaceinvoke r5.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $r6 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var3491 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var889 String (toString/-2075883882 var1560!1)) ; Statement: $r6 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {var3145_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var2793-to-var3145=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), frameworkModel/1756283506=([org.apache.dubbo.qos.command.impl.PublishMetadata], org.apache.dubbo.rpc.model.FrameworkModel), getApplicationModels/1555269024=([org.apache.dubbo.rpc.model.FrameworkModel], java.util.List), var3356_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1149=org.apache.dubbo.qos.command.impl.PublishMetadata, var3616=r2, var2831=org.apache.dubbo.qos.api.CommandContext, var1839=r29, var137=r9, var2793=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1581=$r0, var3145=org.apache.dubbo.common.logger.Logger, var1865="received publishMetadata command.", var1560=$r1, var1907=org.apache.dubbo.rpc.model.FrameworkModel, var964=$r3, var3356=java.util.List, var2411=r4, var1804=r5, var3491=$z0, var889=$r6}
; {org.apache.dubbo.qos.command.impl.PublishMetadata=var1149, r2=var3616, org.apache.dubbo.qos.api.CommandContext=var2831, r29=var1839, r9=var137, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2793, $r0=var1581, org.apache.dubbo.common.logger.Logger=var3145, "received publishMetadata command."=var1865, $r1=var1560, org.apache.dubbo.rpc.model.FrameworkModel=var1907, $r3=var964, java.util.List=var3356, r4=var2411, r5=var1804, $z0=var3491, $r6=var889}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.qos.command.impl.PublishMetadata;	r29 := @parameter0: org.apache.dubbo.qos.api.CommandContext;	r9 := @parameter1: java.lang.String[];	$r0 = <org.apache.dubbo.qos.command.impl.PublishMetadata: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r0.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>("received publishMetadata command.");	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = r2.<org.apache.dubbo.qos.command.impl.PublishMetadata: org.apache.dubbo.rpc.model.FrameworkModel frameworkModel>;	r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.model.FrameworkModel: java.util.List getApplicationModels()>();	r5 = interfaceinvoke r4.<java.util.List: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r5.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $r6 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.String toString()>();	$r6 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 3
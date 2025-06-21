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

(declare-sort var1242 0)
(declare-sort var3241 0)
(declare-sort var609 0)
(declare-sort var3206 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var3241 String) String)
(declare-fun var609-init () var609)
(declare-fun applicationModel/1869075785 (var1242) var3206)
(declare-fun <init>/-2147041069 (var609 var3241 var3206) void)
(declare-const null-var1242 var1242)
(declare-const null-var3241 var3241)
(declare-const var2379 var1242) ; Statement: r4 := @this: org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfigurationFactory 
(assert (not (= var2379 null-var1242)))
(declare-const var1888 var3241) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1888 null-var3241)))
(define-const var2182 var3241 var1888) ; Statement: r6 = r0 
(define-const var1220 String "dubbo") ; Statement: $r2 = "dubbo" 
(assert true)
(define-const var3684 String (getParameter/-1307325648 var1888 "namespace")) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("namespace") 
(assert true)
(define-const var96 Bool (= var1220 var3684)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 == 0 goto $r3 = new org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration 
(assert (= (ite var96 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1083 var609 var609-init) ; Statement: $r3 = new org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration 
(define-const var1944 var3206 (applicationModel/1869075785 var2379)) ; Statement: $r5 = r4.<org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfigurationFactory: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
;(assert (<init>/-2147041069 var1083 var2182 var1944)) ; Statement: specialinvoke $r3.<org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration: void <init>(org.apache.dubbo.common.URL,org.apache.dubbo.rpc.model.ApplicationModel)>(r6, $r5) 

(declare-const var1083!1 var609)
(declare-const var2182!1 var3241)
(declare-const var1944!1 var3206)
 ; Statement: return $r3 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var609-init=([], org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration), applicationModel/1869075785=([org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfigurationFactory], org.apache.dubbo.rpc.model.ApplicationModel), <init>/-2147041069=([org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration, org.apache.dubbo.common.URL, org.apache.dubbo.rpc.model.ApplicationModel], void)}
; {var1242=org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfigurationFactory, var2379=r4, var3241=org.apache.dubbo.common.URL, var1888=r0, var2182=r6, var1220=$r2, var3684=$r1, var96=$z0, var609=org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration, var1083=$r3, var3206=org.apache.dubbo.rpc.model.ApplicationModel, var1944=$r5}
; {org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfigurationFactory=var1242, r4=var2379, org.apache.dubbo.common.URL=var3241, r0=var1888, r6=var2182, $r2=var1220, $r1=var3684, $z0=var96, org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration=var609, $r3=var1083, org.apache.dubbo.rpc.model.ApplicationModel=var3206, $r5=var1944}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r4 := @this: org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfigurationFactory;	r0 := @parameter0: org.apache.dubbo.common.URL;	r6 = r0;	$r2 = "dubbo";	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("namespace");	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 == 0 goto $r3 = new org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration;	$r3 = new org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration;	$r5 = r4.<org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfigurationFactory: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	specialinvoke $r3.<org.apache.dubbo.configcenter.support.nacos.NacosDynamicConfiguration: void <init>(org.apache.dubbo.common.URL,org.apache.dubbo.rpc.model.ApplicationModel)>(r6, $r5);	return $r3
;block_num 2
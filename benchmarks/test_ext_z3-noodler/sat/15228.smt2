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

(declare-sort var1211 0)
(declare-sort var538 0)
(declare-sort var2462 0)
(declare-sort var1779 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getProtocol/491749358 (var2462) String)
(declare-fun getParameter/506106603 (var2462 String String) String)
(declare-fun var1779_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1211 var1211)
(declare-const null-String String)
(declare-const null-var2462 var2462)
(declare-const var2916 var1211) ; Statement: r9 := @this: org.apache.dubbo.registry.integration.RegistryDirectory 
(assert (not (= var2916 null-var1211)))
(declare-const var3919 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var3919 null-String)))
(declare-const var1319 var2462) ; Statement: r0 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var1319 null-var2462)))
(assert true)
(define-const var1701 String (getProtocol/491749358 var1319)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var1567 String (getParameter/506106603 var1319 "preferred.protocol" var1701)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("preferred.protocol", r1) 
(define-const var1324 String var1567) ; Statement: r10 = r2 
(define-const var3802 Bool (var1779_isNotEmpty/-1251449450 var3919)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto return r10 
(assert (= (ite var3802 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r10 
(check-sat)
; {getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String), getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var1779_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1211=org.apache.dubbo.registry.integration.RegistryDirectory, var2916=r9, var3919=r3, var538=null_type, var2462=org.apache.dubbo.common.URL, var1319=r0, var1701=r1, var1567=r2, var1324=r10, var1779=org.apache.dubbo.common.utils.StringUtils, var3802=$z0}
; {org.apache.dubbo.registry.integration.RegistryDirectory=var1211, r9=var2916, r3=var3919, null_type=var538, org.apache.dubbo.common.URL=var2462, r0=var1319, r1=var1701, r2=var1567, r10=var1324, org.apache.dubbo.common.utils.StringUtils=var1779, $z0=var3802}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r9 := @this: org.apache.dubbo.registry.integration.RegistryDirectory;	r3 := @parameter0: java.lang.String;	r0 := @parameter1: org.apache.dubbo.common.URL;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("preferred.protocol", r1);	r10 = r2;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	if $z0 == 0 goto return r10;	return r10
;block_num 2
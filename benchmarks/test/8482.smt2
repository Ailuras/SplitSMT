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

(declare-sort var324 0)
(declare-sort var3532 0)
(declare-sort var73 0)
(declare-sort var3721 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun interfaceName/2049477907 (var3532) String)
(declare-fun cast-from-var324-to-var3532 (var324) var3532)
(declare-fun var73_isEmpty/-813097145 (String) Bool)
(declare-fun var3721-init () var3721)
(declare-fun <init>/-1092629202 (var3721 String) void)
(declare-const null-var324 var324)
(declare-const var1255 var324) ; Statement: r0 := @this: org.apache.dubbo.config.ReferenceConfig 
(assert (not (= var1255 null-var324)))
(define-const var3291 String (interfaceName/2049477907 (cast-from-var324-to-var3532 var1255))) ; Statement: $r1 = r0.<org.apache.dubbo.config.ReferenceConfig: java.lang.String interfaceName> 
(define-const var2116 Bool (var73_isEmpty/-813097145 var3291)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void completeCompoundConfigs()>() 
(assert (not (= (ite var2116 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2536 var3721 var3721-init) ; Statement: $r40 = new java.lang.IllegalStateException 
(assert true)
;(assert (<init>/-1092629202 var2536 "<dubbo:reference interface=\u0022\u0022 /> interface not allow null!")) ; Statement: specialinvoke $r40.<java.lang.IllegalStateException: void <init>(java.lang.String)>("<dubbo:reference interface=\"\" /> interface not allow null!") 

(declare-const var2536!1 var3721)
(declare-const var2773 String)
 ; Statement: throw $r40 
(check-sat)
; {interfaceName/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.String), cast-from-var324-to-var3532=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.config.AbstractInterfaceConfig), var73_isEmpty/-813097145=([java.lang.String], boolean), var3721-init=([], java.lang.IllegalStateException), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var324=org.apache.dubbo.config.ReferenceConfig, var1255=r0, var3532=org.apache.dubbo.config.AbstractInterfaceConfig, var3291=$r1, var73=org.apache.dubbo.common.utils.StringUtils, var2116=$z0, var3721=java.lang.IllegalStateException, var2536=$r40, var2773="<dubbo:reference interface=\"\" /> interface not allow null!"}
; {org.apache.dubbo.config.ReferenceConfig=var324, r0=var1255, org.apache.dubbo.config.AbstractInterfaceConfig=var3532, $r1=var3291, org.apache.dubbo.common.utils.StringUtils=var73, $z0=var2116, java.lang.IllegalStateException=var3721, $r40=var2536, "<dubbo:reference interface=\"\" /> interface not allow null!"=var2773}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ReferenceConfig;	$r1 = r0.<org.apache.dubbo.config.ReferenceConfig: java.lang.String interfaceName>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void completeCompoundConfigs()>();	$r40 = new java.lang.IllegalStateException;	specialinvoke $r40.<java.lang.IllegalStateException: void <init>(java.lang.String)>("<dubbo:reference interface=\"\" /> interface not allow null!");	throw $r40
;block_num 2
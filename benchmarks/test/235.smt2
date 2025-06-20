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

(declare-sort var3092 0)
(declare-sort var279 0)
(declare-sort var447 0)
(declare-sort var2182 0)
(declare-sort var2545 0)
(declare-sort var1635 0)
(declare-sort var470 0)
(declare-sort var3507 0)
(declare-sort var645 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2182_isInfoEnabled/-651841081 (var2182) Bool)
(declare-fun cast-from-var447-to-var2182 (var447) var2182)
(declare-fun getChangeType/-1764226889 (var279) var2545)
(declare-fun equals/1194252418 (var1635 var470) Bool)
(declare-fun cast-from-var2545-to-var1635 (var2545) var1635)
(declare-fun cast-from-var2545-to-var470 (var2545) var470)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getContent/-1672188143 (var279) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var447_error/377575788 (var447 String String String String var645) void)
(declare-fun cast-from-var3507-to-var645 (var3507) var645)
(declare-const null-var3092 var3092)
(declare-const null-var279 var279)
(declare-const var3092-logger var447)
(declare-const var2545-DELETED var2545)
(declare-const null-var3507 var3507)
(declare-const var474 var3092) ; Statement: r4 := @this: org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter 
(assert (not (= var474 null-var3092)))
(declare-const var781 var279) ; Statement: r1 := @parameter0: org.apache.dubbo.common.config.configcenter.ConfigChangedEvent 
(assert (not (= var781 null-var279)))
(define-const var1719 var447 var3092-logger) ; Statement: $r0 = <org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3329 Bool (var2182_isInfoEnabled/-651841081 (cast-from-var447-to-var2182 var1719))) ; Statement: $z0 = interfaceinvoke $r0.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isInfoEnabled()>() 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r1.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: org.apache.dubbo.common.config.configcenter.ConfigChangeType getChangeType()>() 
(assert (= (ite var3329 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var868 var2545 (getChangeType/-1764226889 var781)) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: org.apache.dubbo.common.config.configcenter.ConfigChangeType getChangeType()>() 
(define-const var44 var2545 var2545-DELETED) ; Statement: $r2 = <org.apache.dubbo.common.config.configcenter.ConfigChangeType: org.apache.dubbo.common.config.configcenter.ConfigChangeType DELETED> 
(assert true)
(define-const var1307 Bool (equals/1194252418 (cast-from-var2545-to-var1635 var868) (cast-from-var2545-to-var470 var44))) ; Statement: $z1 = virtualinvoke $r3.<org.apache.dubbo.common.config.configcenter.ConfigChangeType: boolean equals(java.lang.Object)>($r2) 
 ; Statement: if $z1 == 0 goto $r5 = virtualinvoke r1.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: java.lang.String getContent()>() 
(assert (not (= (ite var1307 1 0) 0))) ; Negate: Cond: $z1 == 0  
(declare-const var2557 var3507) ; Statement: $r19 := @caughtexception 
(assert (not (= var2557 null-var3507)))
(define-const var492 var447 var3092-logger) ; Statement: $r21 = <org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3336 String String-init) ; Statement: $r20 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3336)) ; Statement: specialinvoke $r20.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3336!1 String)
(assert (= var3336!1 ""))
(assert true)
(define-const var3057 String (append/672562846 var3336!1 "Failed to parse the raw condition rule and it will not take effect, please check if the condition rule matches with the template, the raw rule is:\n ")) ; Statement: $r23 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to parse the raw condition rule and it will not take effect, please check if the condition rule matches with the template, the raw rule is:\n ") 
(declare-const var3336!2 String)
(assert (= var3336!2 (str.++ var3336!1 "Failed to parse the raw condition rule and it will not take effect, please check if the condition rule matches with the template, the raw rule is:\n ")))
(assert true)
(define-const var3493 String (getContent/-1672188143 var781)) ; Statement: $r22 = virtualinvoke r1.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: java.lang.String getContent()>() 
(assert true)
(define-const var3245 String (append/672562846 var3057 var3493)) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r22) 
(declare-const var3057!1 String)
(assert (= var3057!1 (str.++ var3057 var3493)))
(assert true)
(define-const var96 String (toString/-2075883882 var3245)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var447_error/377575788 var492 "2-15" "Failed to parse the raw condition rule" "" var96 (cast-from-var3507-to-var645 var2557))) ; Statement: interfaceinvoke $r21.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-15", "Failed to parse the raw condition rule", "", $r25, $r19) 

(declare-const var492!1 var447)
(declare-const var3763 String)
(declare-const var1174 String)
(declare-const var2880 String)
(declare-const var96!1 String)
(declare-const var2557!1 var3507)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {var2182_isInfoEnabled/-651841081=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var447-to-var2182=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), getChangeType/-1764226889=([org.apache.dubbo.common.config.configcenter.ConfigChangedEvent], org.apache.dubbo.common.config.configcenter.ConfigChangeType), equals/1194252418=([java.lang.Enum, java.lang.Object], boolean), cast-from-var2545-to-var1635=([org.apache.dubbo.common.config.configcenter.ConfigChangeType], java.lang.Enum), cast-from-var2545-to-var470=([org.apache.dubbo.common.config.configcenter.ConfigChangeType], java.lang.Object), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getContent/-1672188143=([org.apache.dubbo.common.config.configcenter.ConfigChangedEvent], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var447_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), cast-from-var3507-to-var645=([java.lang.Exception], java.lang.Throwable)}
; {var3092=org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter, var474=r4, var279=org.apache.dubbo.common.config.configcenter.ConfigChangedEvent, var781=r1, var447=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1719=$r0, var2182=org.apache.dubbo.common.logger.Logger, var3329=$z0, var2545=org.apache.dubbo.common.config.configcenter.ConfigChangeType, var868=$r3, var44=$r2, var1635=java.lang.Enum, var470=java.lang.Object, var1307=$z1, var3507=java.lang.Exception, var2557=$r19, var492=$r21, var3336=$r20, var3057=$r23, var3493=$r22, var3245=$r24, var96=$r25, var645=java.lang.Throwable, var3763="2-15", var1174="Failed to parse the raw condition rule", var2880=""}
; {org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter=var3092, r4=var474, org.apache.dubbo.common.config.configcenter.ConfigChangedEvent=var279, r1=var781, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var447, $r0=var1719, org.apache.dubbo.common.logger.Logger=var2182, $z0=var3329, org.apache.dubbo.common.config.configcenter.ConfigChangeType=var2545, $r3=var868, $r2=var44, java.lang.Enum=var1635, java.lang.Object=var470, $z1=var1307, java.lang.Exception=var3507, $r19=var2557, $r21=var492, $r20=var3336, $r23=var3057, $r22=var3493, $r24=var3245, $r25=var96, java.lang.Throwable=var645, "2-15"=var3763, "Failed to parse the raw condition rule"=var1174, ""=var2880}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r4 := @this: org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter;	r1 := @parameter0: org.apache.dubbo.common.config.configcenter.ConfigChangedEvent;	$r0 = <org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z0 = interfaceinvoke $r0.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isInfoEnabled()>();	if $z0 == 0 goto $r3 = virtualinvoke r1.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: org.apache.dubbo.common.config.configcenter.ConfigChangeType getChangeType()>();	$r3 = virtualinvoke r1.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: org.apache.dubbo.common.config.configcenter.ConfigChangeType getChangeType()>();	$r2 = <org.apache.dubbo.common.config.configcenter.ConfigChangeType: org.apache.dubbo.common.config.configcenter.ConfigChangeType DELETED>;	$z1 = virtualinvoke $r3.<org.apache.dubbo.common.config.configcenter.ConfigChangeType: boolean equals(java.lang.Object)>($r2);	if $z1 == 0 goto $r5 = virtualinvoke r1.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: java.lang.String getContent()>();	$r19 := @caughtexception;	$r21 = <org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r20 = new java.lang.StringBuilder;	specialinvoke $r20.<java.lang.StringBuilder: void <init>()>();	$r23 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to parse the raw condition rule and it will not take effect, please check if the condition rule matches with the template, the raw rule is:\n ");	$r22 = virtualinvoke r1.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: java.lang.String getContent()>();	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r22);	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r21.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-15", "Failed to parse the raw condition rule", "", $r25, $r19);	return
;block_num 4
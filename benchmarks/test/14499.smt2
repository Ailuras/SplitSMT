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

(declare-sort var313 0)
(declare-sort var948 0)
(declare-sort var279 0)
(declare-sort var2952 0)
(declare-sort var3136 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun metadataServicePort/-1257254642 (var313) Int)
(declare-fun logger/-1257254642 (var313) var279)
(declare-fun var279_warn/1431914100 (var279 String String String String) void)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2952-init () var2952)
(declare-fun <init>/-1092629202 (var2952 String) void)
(declare-fun var279_error/377575788 (var279 String String String String var3136) void)
(declare-fun cast-from-var2952-to-var3136 (var2952) var3136)
(declare-const null-var313 var313)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3462 var313) ; Statement: r0 := @this: org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder 
(assert (not (= var3462 null-var313)))
(declare-const var1656 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var1656 null-String)))
(declare-const var887 String) ; Statement: r7 := @parameter1: java.lang.String 
(assert (not (= var887 null-String)))
(declare-const var2540 Int) ; Statement: r2 := @parameter2: java.lang.Integer 
(assert (not (= var2540 null-Int)))
(define-const var635 Int (metadataServicePort/-1257254642 var3462)) ; Statement: r27 = r0.<org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder: java.lang.Integer metadataServicePort> 
 ; Statement: if r27 == null goto $r1 = r0.<org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(assert (= var635 null-Int)) ; Cond: r27 == null 
(define-const var1028 var279 (logger/-1257254642 var3462)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var279_warn/1431914100 var1028 "1-18" "missing configuration of metadata service port" "" "Metadata Service Port is not provided. Since DNS is not able to negotiate the metadata port between Provider and Consumer, Dubbo will try using instance port as the default metadata port.")) ; Statement: interfaceinvoke $r1.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("1-18", "missing configuration of metadata service port", "", "Metadata Service Port is not provided. Since DNS is not able to negotiate the metadata port between Provider and Consumer, Dubbo will try using instance port as the default metadata port.") 

(declare-const var1028!1 var279)
(declare-const var1322 String)
(declare-const var594 String)
(declare-const var3912 String)
(declare-const var152 String)
(define-const var635!1 Int var2540) ; Statement: r27 = r2 
(assert true) ; Non Conditional
 ; Statement: if r27 == null goto $r3 = new java.lang.StringBuilder 
(assert (= var635!1 null-Int)) ; Cond: r27 == null 
(define-const var1691 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1691)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1691!1 String)
(assert (= var1691!1 ""))
(assert true)
(define-const var3342 String (append/672562846 var1691!1 "Metadata Service Port should be specified for consumer. Please set dubbo.application.metadataServicePort and make sure it has been set on provider side. ServiceName: ")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Metadata Service Port should be specified for consumer. Please set dubbo.application.metadataServicePort and make sure it has been set on provider side. ServiceName: ") 
(declare-const var1691!2 String)
(assert (= var1691!2 (str.++ var1691!1 "Metadata Service Port should be specified for consumer. Please set dubbo.application.metadataServicePort and make sure it has been set on provider side. ServiceName: ")))
(assert true)
(define-const var3266 String (append/672562846 var3342 var1656)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var3342!1 String)
(assert (= var3342!1 (str.++ var3342 var1656)))
(assert true)
(define-const var2919 String (append/672562846 var3266 " Host: ")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Host: ") 
(declare-const var3266!1 String)
(assert (= var3266!1 (str.++ var3266 " Host: ")))
(assert true)
(define-const var3851 String (append/672562846 var2919 var887)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7) 
(declare-const var2919!1 String)
(assert (= var2919!1 (str.++ var2919 var887)))
(assert true)
(define-const var892 String (toString/-2075883882 var3851)) ; Statement: $r26 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var2825 var2952 var2952-init) ; Statement: $r10 = new java.lang.IllegalStateException 
(assert true)
;(assert (<init>/-1092629202 var2825 var892)) ; Statement: specialinvoke $r10.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r26) 

(declare-const var2825!1 var2952)
(declare-const var892!1 String)
(define-const var1654 var279 (logger/-1257254642 var3462)) ; Statement: $r11 = r0.<org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var279_error/377575788 var1654 "1-18" "missing configuration of metadata service port" "" var892!1 (cast-from-var2952-to-var3136 var2825!1))) ; Statement: interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("1-18", "missing configuration of metadata service port", "", $r26, $r10) 

(declare-const var1654!1 var279)
(declare-const var1322!1 String)
(declare-const var594!1 String)
(declare-const var3912!1 String)
(declare-const var892!2 String)
(declare-const var2825!2 var2952)
 ; Statement: throw $r10 
(check-sat)
; {metadataServicePort/-1257254642=([org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder], java.lang.Integer), logger/-1257254642=([org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), var279_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2952-init=([], java.lang.IllegalStateException), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void), var279_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), cast-from-var2952-to-var3136=([java.lang.IllegalStateException], java.lang.Throwable)}
; {var313=org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder, var3462=r0, var1656=r4, var948=null_type, var887=r7, var2540=r2, var635=r27, var279=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1028=$r1, var1322="1-18", var594="missing configuration of metadata service port", var3912="", var152="Metadata Service Port is not provided. Since DNS is not able to negotiate the metadata port between Provider and Consumer, Dubbo will try using instance port as the default metadata port.", var1691=$r3, var3342=$r5, var3266=$r6, var2919=$r8, var3851=$r9, var892=$r26, var2952=java.lang.IllegalStateException, var2825=$r10, var1654=$r11, var3136=java.lang.Throwable}
; {org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder=var313, r0=var3462, r4=var1656, null_type=var948, r7=var887, r2=var2540, r27=var635, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var279, $r1=var1028, "1-18"=var1322, "missing configuration of metadata service port"=var594, ""=var3912, "Metadata Service Port is not provided. Since DNS is not able to negotiate the metadata port between Provider and Consumer, Dubbo will try using instance port as the default metadata port."=var152, $r3=var1691, $r5=var3342, $r6=var3266, $r8=var2919, $r9=var3851, $r26=var892, java.lang.IllegalStateException=var2952, $r10=var2825, $r11=var1654, java.lang.Throwable=var3136}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder;	r4 := @parameter0: java.lang.String;	r7 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.Integer;	r27 = r0.<org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder: java.lang.Integer metadataServicePort>;	if r27 == null goto $r1 = r0.<org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r1 = r0.<org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r1.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("1-18", "missing configuration of metadata service port", "", "Metadata Service Port is not provided. Since DNS is not able to negotiate the metadata port between Provider and Consumer, Dubbo will try using instance port as the default metadata port.");	r27 = r2;	if r27 == null goto $r3 = new java.lang.StringBuilder;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Metadata Service Port should be specified for consumer. Please set dubbo.application.metadataServicePort and make sure it has been set on provider side. ServiceName: ");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Host: ");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7);	$r26 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	$r10 = new java.lang.IllegalStateException;	specialinvoke $r10.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r26);	$r11 = r0.<org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("1-18", "missing configuration of metadata service port", "", $r26, $r10);	throw $r10
;block_num 4
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

(declare-sort var2244 0)
(declare-sort var1963 0)
(declare-sort var213 0)
(declare-sort var3267 0)
(declare-sort var977 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun metadataServicePort/-1257254642 (var2244) Int)
(declare-fun intValue/-1815674922 (Int) Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var213-init () var213)
(declare-fun <init>/-1092629202 (var213 String) void)
(declare-fun logger/-1257254642 (var2244) var3267)
(declare-fun var3267_error/377575788 (var3267 String String String String var977) void)
(declare-fun cast-from-var213-to-var977 (var213) var977)
(declare-const null-var2244 var2244)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1997 var2244) ; Statement: r0 := @this: org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder 
(assert (not (= var1997 null-var2244)))
(declare-const var3853 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var3853 null-String)))
(declare-const var139 String) ; Statement: r7 := @parameter1: java.lang.String 
(assert (not (= var139 null-String)))
(declare-const var3723 Int) ; Statement: r2 := @parameter2: java.lang.Integer 
(assert (not (= var3723 null-Int)))
(define-const var1472 Int (metadataServicePort/-1257254642 var1997)) ; Statement: r27 = r0.<org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder: java.lang.Integer metadataServicePort> 
 ; Statement: if r27 == null goto $r1 = r0.<org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(assert (not (= var1472 null-Int))) ; Negate: Cond: r27 == null  
(assert true)
(define-const var728 Int (intValue/-1815674922 var1472)) ; Statement: $i3 = virtualinvoke r27.<java.lang.Integer: int intValue()>() 
 ; Statement: if $i3 >= 1 goto (branch) 
(assert (>= var728 1)) ; Cond: $i3 >= 1 
 ; Statement: if r27 == null goto $r3 = new java.lang.StringBuilder 
(assert (= var1472 null-Int)) ; Cond: r27 == null 
(define-const var1585 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1585)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1585!1 String)
(assert (= var1585!1 ""))
(assert true)
(define-const var3398 String (append/672562846 var1585!1 "Metadata Service Port should be specified for consumer. Please set dubbo.application.metadataServicePort and make sure it has been set on provider side. ServiceName: ")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Metadata Service Port should be specified for consumer. Please set dubbo.application.metadataServicePort and make sure it has been set on provider side. ServiceName: ") 
(declare-const var1585!2 String)
(assert (= var1585!2 (str.++ var1585!1 "Metadata Service Port should be specified for consumer. Please set dubbo.application.metadataServicePort and make sure it has been set on provider side. ServiceName: ")))
(assert true)
(define-const var2460 String (append/672562846 var3398 var3853)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var3398!1 String)
(assert (= var3398!1 (str.++ var3398 var3853)))
(assert true)
(define-const var35 String (append/672562846 var2460 " Host: ")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Host: ") 
(declare-const var2460!1 String)
(assert (= var2460!1 (str.++ var2460 " Host: ")))
(assert true)
(define-const var3544 String (append/672562846 var35 var139)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7) 
(declare-const var35!1 String)
(assert (= var35!1 (str.++ var35 var139)))
(assert true)
(define-const var463 String (toString/-2075883882 var3544)) ; Statement: $r26 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var1054 var213 var213-init) ; Statement: $r10 = new java.lang.IllegalStateException 
(assert true)
;(assert (<init>/-1092629202 var1054 var463)) ; Statement: specialinvoke $r10.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r26) 

(declare-const var1054!1 var213)
(declare-const var463!1 String)
(define-const var3783 var3267 (logger/-1257254642 var1997)) ; Statement: $r11 = r0.<org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var3267_error/377575788 var3783 "1-18" "missing configuration of metadata service port" "" var463!1 (cast-from-var213-to-var977 var1054!1))) ; Statement: interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("1-18", "missing configuration of metadata service port", "", $r26, $r10) 

(declare-const var3783!1 var3267)
(declare-const var22 String)
(declare-const var2091 String)
(declare-const var2161 String)
(declare-const var463!2 String)
(declare-const var1054!2 var213)
 ; Statement: throw $r10 
(check-sat)
; {metadataServicePort/-1257254642=([org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder], java.lang.Integer), intValue/-1815674922=([java.lang.Integer], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var213-init=([], java.lang.IllegalStateException), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void), logger/-1257254642=([org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), var3267_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), cast-from-var213-to-var977=([java.lang.IllegalStateException], java.lang.Throwable)}
; {var2244=org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder, var1997=r0, var3853=r4, var1963=null_type, var139=r7, var3723=r2, var1472=r27, var728=$i3, var1585=$r3, var3398=$r5, var2460=$r6, var35=$r8, var3544=$r9, var463=$r26, var213=java.lang.IllegalStateException, var1054=$r10, var3267=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3783=$r11, var977=java.lang.Throwable, var22="1-18", var2091="missing configuration of metadata service port", var2161=""}
; {org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder=var2244, r0=var1997, r4=var3853, null_type=var1963, r7=var139, r2=var3723, r27=var1472, $i3=var728, $r3=var1585, $r5=var3398, $r6=var2460, $r8=var35, $r9=var3544, $r26=var463, java.lang.IllegalStateException=var213, $r10=var1054, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3267, $r11=var3783, java.lang.Throwable=var977, "1-18"=var22, "missing configuration of metadata service port"=var2091, ""=var2161}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder;	r4 := @parameter0: java.lang.String;	r7 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.Integer;	r27 = r0.<org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder: java.lang.Integer metadataServicePort>;	if r27 == null goto $r1 = r0.<org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$i3 = virtualinvoke r27.<java.lang.Integer: int intValue()>();	if $i3 >= 1 goto (branch);	if r27 == null goto $r3 = new java.lang.StringBuilder;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Metadata Service Port should be specified for consumer. Please set dubbo.application.metadataServicePort and make sure it has been set on provider side. ServiceName: ");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" Host: ");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r7);	$r26 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	$r10 = new java.lang.IllegalStateException;	specialinvoke $r10.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r26);	$r11 = r0.<org.apache.dubbo.registry.client.metadata.StandardMetadataServiceURLBuilder: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("1-18", "missing configuration of metadata service port", "", $r26, $r10);	throw $r10
;block_num 4
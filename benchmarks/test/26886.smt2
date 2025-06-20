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

(declare-sort var1675 0)
(declare-sort var2466 0)
(declare-sort var3315 0)
(declare-sort var524 0)
(declare-sort var2397 0)
(declare-sort var781 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3315) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2397_warn/126438324 (var2397 String String String String var524) void)
(declare-const null-var1675 var1675)
(declare-const null-String String)
(declare-const null-var3315 var3315)
(declare-const null-var524 var524)
(declare-const var781-LOGGER var2397)
(declare-const var2043 var1675) ; Statement: r1 := @parameter0: java.util.function.BiConsumer 
(assert (not (= var2043 null-var1675)))
(declare-const var1847 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1847 null-String)))
(declare-const var2943 var3315) ; Statement: r0 := @parameter2: java.lang.Object 
(assert (not (= var2943 null-var3315)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2195 var524) ; Statement: $r19 := @caughtexception 
(assert (not (= var2195 null-var524)))
(define-const var1564 var2397 var781-LOGGER) ; Statement: $r21 = <org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER> 
(define-const var2504 String String-init) ; Statement: $r20 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2504)) ; Statement: specialinvoke $r20.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2504!1 String)
(assert (= var2504!1 ""))
(assert true)
(define-const var1361 String (append/672562846 var2504!1 "Meet exception when convert single attachment key:")) ; Statement: $r22 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Meet exception when convert single attachment key:") 
(declare-const var2504!2 String)
(assert (= var2504!2 (str.++ var2504!1 "Meet exception when convert single attachment key:")))
(assert true)
(define-const var2417 String (append/672562846 var1361 var1847)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var1361!1 String)
(assert (= var1361!1 (str.++ var1361 var1847)))
(assert true)
(define-const var181 String (append/672562846 var2417 " value=")) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" value=") 
(declare-const var2417!1 String)
(assert (= var2417!1 (str.++ var2417 " value=")))
(assert true)
(define-const var2429 String (append/-1031950772 var181 var2943)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var181!1 String)
(assert (str.prefixof var181 var181!1))
(assert true)
(define-const var1426 String (toString/-2075883882 var2429)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2397_warn/126438324 var1564 "4-1" "" "" var1426 var2195)) ; Statement: interfaceinvoke $r21.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("4-1", "", "", $r26, $r19) 

(declare-const var1564!1 var2397)
(declare-const var3353 String)
(declare-const var2589 String)
(declare-const var2589!1 String)
(declare-const var1426!1 String)
(declare-const var2195!1 var524)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2397_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var1675=java.util.function.BiConsumer, var2043=r1, var1847=r2, var2466=null_type, var3315=java.lang.Object, var2943=r0, var524=java.lang.Throwable, var2195=$r19, var2397=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var781=org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils, var1564=$r21, var2504=$r20, var1361=$r22, var2417=$r23, var181=$r24, var2429=$r25, var1426=$r26, var3353="4-1", var2589=""}
; {java.util.function.BiConsumer=var1675, r1=var2043, r2=var1847, null_type=var2466, java.lang.Object=var3315, r0=var2943, java.lang.Throwable=var524, $r19=var2195, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2397, org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils=var781, $r21=var1564, $r20=var2504, $r22=var1361, $r23=var2417, $r24=var181, $r25=var2429, $r26=var1426, "4-1"=var3353, ""=var2589}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.util.function.BiConsumer;	r2 := @parameter1: java.lang.String;	r0 := @parameter2: java.lang.Object;	$r19 := @caughtexception;	$r21 = <org.apache.dubbo.rpc.protocol.tri.stream.StreamUtils: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER>;	$r20 = new java.lang.StringBuilder;	specialinvoke $r20.<java.lang.StringBuilder: void <init>()>();	$r22 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Meet exception when convert single attachment key:");	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" value=");	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r21.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("4-1", "", "", $r26, $r19);	return
;block_num 3
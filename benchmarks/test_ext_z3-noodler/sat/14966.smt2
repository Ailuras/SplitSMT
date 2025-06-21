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

(declare-sort var2763 0)
(declare-sort var761 0)
(declare-sort var1533 0)
(declare-sort var288 0)
(declare-sort var2190 0)
(declare-sort var1719 0)
(declare-sort var1050 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun stringUrls/-1068639500 (var2763) var1533)
(declare-fun var1533_remove/-1201052315 (var1533 var288) var288)
(declare-fun cast-from-var761-to-var288 (var761) var288)
(declare-fun cast-from-var288-to-var1533 (var288) var1533)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getServiceKey/1456125852 (var761) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1719_warn/126438324 (var1719 String String String String var1050) void)
(declare-fun cast-from-var2190-to-var1050 (var2190) var1050)
(declare-const null-var2763 var2763)
(declare-const null-var761 var761)
(declare-const null-var2190 var2190)
(declare-const var2763-logger var1719)
(declare-const var234 var2763) ; Statement: r0 := @this: org.apache.dubbo.registry.support.CacheableFailbackRegistry 
(assert (not (= var234 null-var2763)))
(declare-const var1004 var761) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1004 null-var761)))
(define-const var1286 var1533 (stringUrls/-1068639500 var234)) ; Statement: $r2 = r0.<org.apache.dubbo.registry.support.CacheableFailbackRegistry: java.util.Map stringUrls> 
(define-const var2417 var288 (var1533_remove/-1201052315 var1286 (cast-from-var761-to-var288 var1004))) ; Statement: $r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object remove(java.lang.Object)>(r1) 
(define-const var3394 var1533 (cast-from-var288-to-var1533 var2417)) ; Statement: r4 = (java.util.Map) $r3 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2828 var2190) ; Statement: $r25 := @caughtexception 
(assert (not (= var2828 null-var2190)))
(define-const var1716 var1719 var2763-logger) ; Statement: $r27 = <org.apache.dubbo.registry.support.CacheableFailbackRegistry: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2330 String String-init) ; Statement: $r26 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2330)) ; Statement: specialinvoke $r26.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2330!1 String)
(assert (= var2330!1 ""))
(assert true)
(define-const var1553 String (append/672562846 var2330!1 "Failed to evict url for ")) ; Statement: $r29 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to evict url for ") 
(declare-const var2330!2 String)
(assert (= var2330!2 (str.++ var2330!1 "Failed to evict url for ")))
(assert true)
(define-const var413 String (getServiceKey/1456125852 var1004)) ; Statement: $r28 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
(assert true)
(define-const var3165 String (append/672562846 var1553 var413)) ; Statement: $r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r28) 
(declare-const var1553!1 String)
(assert (= var1553!1 (str.++ var1553 var413)))
(assert true)
(define-const var1307 String (toString/-2075883882 var3165)) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1719_warn/126438324 var1716 "1-3" "thread pool getting destroyed" "" var1307 (cast-from-var2190-to-var1050 var2828))) ; Statement: interfaceinvoke $r27.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("1-3", "thread pool getting destroyed", "", $r31, $r25) 

(declare-const var1716!1 var1719)
(declare-const var3358 String)
(declare-const var1230 String)
(declare-const var1188 String)
(declare-const var1307!1 String)
(declare-const var2828!1 var2190)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {stringUrls/-1068639500=([org.apache.dubbo.registry.support.CacheableFailbackRegistry], java.util.Map), var1533_remove/-1201052315=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var761-to-var288=([org.apache.dubbo.common.URL], java.lang.Object), cast-from-var288-to-var1533=([java.lang.Object], java.util.Map), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1719_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), cast-from-var2190-to-var1050=([java.lang.Exception], java.lang.Throwable)}
; {var2763=org.apache.dubbo.registry.support.CacheableFailbackRegistry, var234=r0, var761=org.apache.dubbo.common.URL, var1004=r1, var1533=java.util.Map, var1286=$r2, var288=java.lang.Object, var2417=$r3, var3394=r4, var2190=java.lang.Exception, var2828=$r25, var1719=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1716=$r27, var2330=$r26, var1553=$r29, var413=$r28, var3165=$r30, var1307=$r31, var1050=java.lang.Throwable, var3358="1-3", var1230="thread pool getting destroyed", var1188=""}
; {org.apache.dubbo.registry.support.CacheableFailbackRegistry=var2763, r0=var234, org.apache.dubbo.common.URL=var761, r1=var1004, java.util.Map=var1533, $r2=var1286, java.lang.Object=var288, $r3=var2417, r4=var3394, java.lang.Exception=var2190, $r25=var2828, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1719, $r27=var1716, $r26=var2330, $r29=var1553, $r28=var413, $r30=var3165, $r31=var1307, java.lang.Throwable=var1050, "1-3"=var3358, "thread pool getting destroyed"=var1230, ""=var1188}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.support.CacheableFailbackRegistry;	r1 := @parameter0: org.apache.dubbo.common.URL;	$r2 = r0.<org.apache.dubbo.registry.support.CacheableFailbackRegistry: java.util.Map stringUrls>;	$r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object remove(java.lang.Object)>(r1);	r4 = (java.util.Map) $r3;	$r25 := @caughtexception;	$r27 = <org.apache.dubbo.registry.support.CacheableFailbackRegistry: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r26 = new java.lang.StringBuilder;	specialinvoke $r26.<java.lang.StringBuilder: void <init>()>();	$r29 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to evict url for ");	$r28 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	$r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r28);	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r27.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("1-3", "thread pool getting destroyed", "", $r31, $r25);	return
;block_num 3
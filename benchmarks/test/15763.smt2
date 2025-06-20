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

(declare-sort var1525 0)
(declare-sort var2166 0)
(declare-sort var2342 0)
(declare-sort var1648 0)
(declare-sort var3312 0)
(declare-sort var1872 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getAndIncrement/-1505044446 (var2166 var2342) Int)
(declare-fun cast-from-var1525-to-var2342 (var1525) var2342)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun getAndDecrement/-295953282 (var2166 var2342) Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun remote/-1507818110 (var1525) var3312)
(declare-fun append/-1031950772 (String var2342) String)
(declare-fun cast-from-var3312-to-var2342 (var3312) var2342)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1872_info/484404803 (var1872 String) void)
(declare-fun cast-from-var1648-to-var1872 (var1648) var1872)
(declare-const null-var1525 var1525)
(declare-const var1525-COUNTER_UPDATER var2166)
(declare-const var1525-logger var1648)
(declare-const var1940 var1525) ; Statement: r0 := @this: org.apache.dubbo.remoting.api.connection.AbstractConnectionClient 
(assert (not (= var1940 null-var1525)))
(define-const var3589 var2166 var1525-COUNTER_UPDATER) ; Statement: $r1 = <org.apache.dubbo.remoting.api.connection.AbstractConnectionClient: java.util.concurrent.atomic.AtomicLongFieldUpdater COUNTER_UPDATER> 
(assert true)
(define-const var2335 Int (getAndIncrement/-1505044446 var3589 (cast-from-var1525-to-var2342 var1940))) ; Statement: l0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicLongFieldUpdater: long getAndIncrement(java.lang.Object)>(r0) 
(define-const var1291 Int (ite (> var2335 0) 1 (ite (< var2335 0) -1 0))) ; Statement: $b1 = l0 cmp 0L 
(define-const var1512 Int (cast-from-Int-to-Int var1291)) ; Statement: $i2 = (int) $b1 
 ; Statement: if $i2 > 0 goto return 1 
(assert (not (> var1512 0))) ; Negate: Cond: $i2 > 0  
(define-const var2678 var2166 var1525-COUNTER_UPDATER) ; Statement: $r2 = <org.apache.dubbo.remoting.api.connection.AbstractConnectionClient: java.util.concurrent.atomic.AtomicLongFieldUpdater COUNTER_UPDATER> 
(assert true)
;(assert (getAndDecrement/-295953282 var2678 (cast-from-var1525-to-var2342 var1940))) ; Statement: virtualinvoke $r2.<java.util.concurrent.atomic.AtomicLongFieldUpdater: long getAndDecrement(java.lang.Object)>(r0) 

(declare-const var2678!1 var2166)
(declare-const var1940!1 var1525)
(define-const var1834 var1648 var1525-logger) ; Statement: $r4 = <org.apache.dubbo.remoting.api.connection.AbstractConnectionClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1936 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1936)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1936!1 String)
(assert (= var1936!1 ""))
(assert true)
(define-const var2250 String (append/672562846 var1936!1 "Retain failed, because connection ")) ; Statement: $r6 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Retain failed, because connection ") 
(declare-const var1936!2 String)
(assert (= var1936!2 (str.++ var1936!1 "Retain failed, because connection ")))
(define-const var2813 var3312 (remote/-1507818110 var1940!1)) ; Statement: $r5 = r0.<org.apache.dubbo.remoting.api.connection.AbstractConnectionClient: java.net.InetSocketAddress remote> 
(assert true)
(define-const var1206 String (append/-1031950772 var2250 (cast-from-var3312-to-var2342 var2813))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var2250!1 String)
(assert (str.prefixof var2250 var2250!1))
(assert true)
(define-const var3539 String (append/672562846 var1206 " has been destroyed but not yet removed, will create a new one instead. Check logs below to confirm that this connection finally gets removed to make sure there\u0027s no potential memory leak!")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" has been destroyed but not yet removed, will create a new one instead. Check logs below to confirm that this connection finally gets removed to make sure there\'s no potential memory leak!") 
(declare-const var1206!1 String)
(assert (= var1206!1 (str.++ var1206 " has been destroyed but not yet removed, will create a new one instead. Check logs below to confirm that this connection finally gets removed to make sure there\u0027s no potential memory leak!")))
(assert true)
(define-const var2831 String (toString/-2075883882 var3539)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1872_info/484404803 (cast-from-var1648-to-var1872 var1834) var2831)) ; Statement: interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r9) 

(declare-const var1834!1 var1648)
(declare-const var2831!1 String)
 ; Statement: return 0 
(check-sat)
; {getAndIncrement/-1505044446=([java.util.concurrent.atomic.AtomicLongFieldUpdater, java.lang.Object], long), cast-from-var1525-to-var2342=([org.apache.dubbo.remoting.api.connection.AbstractConnectionClient], java.lang.Object), cast-from-Int-to-Int=([byte], int), getAndDecrement/-295953282=([java.util.concurrent.atomic.AtomicLongFieldUpdater, java.lang.Object], long), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), remote/-1507818110=([org.apache.dubbo.remoting.api.connection.AbstractConnectionClient], java.net.InetSocketAddress), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3312-to-var2342=([java.net.InetSocketAddress], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1872_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var1648-to-var1872=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger)}
; {var1525=org.apache.dubbo.remoting.api.connection.AbstractConnectionClient, var1940=r0, var2166=java.util.concurrent.atomic.AtomicLongFieldUpdater, var3589=$r1, var2342=java.lang.Object, var2335=l0, var1291=$b1, var1512=$i2, var2678=$r2, var1648=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1834=$r4, var1936=$r10, var2250=$r6, var3312=java.net.InetSocketAddress, var2813=$r5, var1206=$r7, var3539=$r8, var2831=$r9, var1872=org.apache.dubbo.common.logger.Logger}
; {org.apache.dubbo.remoting.api.connection.AbstractConnectionClient=var1525, r0=var1940, java.util.concurrent.atomic.AtomicLongFieldUpdater=var2166, $r1=var3589, java.lang.Object=var2342, l0=var2335, $b1=var1291, $i2=var1512, $r2=var2678, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1648, $r4=var1834, $r10=var1936, $r6=var2250, java.net.InetSocketAddress=var3312, $r5=var2813, $r7=var1206, $r8=var3539, $r9=var2831, org.apache.dubbo.common.logger.Logger=var1872}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.api.connection.AbstractConnectionClient;	$r1 = <org.apache.dubbo.remoting.api.connection.AbstractConnectionClient: java.util.concurrent.atomic.AtomicLongFieldUpdater COUNTER_UPDATER>;	l0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicLongFieldUpdater: long getAndIncrement(java.lang.Object)>(r0);	$b1 = l0 cmp 0L;	$i2 = (int) $b1;	if $i2 > 0 goto return 1;	$r2 = <org.apache.dubbo.remoting.api.connection.AbstractConnectionClient: java.util.concurrent.atomic.AtomicLongFieldUpdater COUNTER_UPDATER>;	virtualinvoke $r2.<java.util.concurrent.atomic.AtomicLongFieldUpdater: long getAndDecrement(java.lang.Object)>(r0);	$r4 = <org.apache.dubbo.remoting.api.connection.AbstractConnectionClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Retain failed, because connection ");	$r5 = r0.<org.apache.dubbo.remoting.api.connection.AbstractConnectionClient: java.net.InetSocketAddress remote>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" has been destroyed but not yet removed, will create a new one instead. Check logs below to confirm that this connection finally gets removed to make sure there\'s no potential memory leak!");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r9);	return 0
;block_num 2
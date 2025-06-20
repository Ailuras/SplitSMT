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

(declare-sort var3698 0)
(declare-sort var72 0)
(declare-sort var3338 0)
(declare-sort var1435 0)
(declare-sort var3232 0)
(declare-sort var3005 0)
(declare-sort var2736 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getURLBackupAddress/-1639040226 (var3698 var72) var3338)
(declare-fun fetchAndUpdateZookeeperClientCache/54942657 (var3698 var3338) var1435)
(declare-fun var1435_isConnected/933606471 (var1435) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3005) String)
(declare-fun cast-from-var72-to-var3005 (var72) var3005)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2736_info/484404803 (var2736 String) void)
(declare-fun cast-from-var3232-to-var2736 (var3232) var2736)
(declare-const null-var3698 var3698)
(declare-const null-var72 var72)
(declare-const null-var1435 var1435)
(declare-const var3698-logger var3232)
(declare-const var3877 var3698) ; Statement: r0 := @this: org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager 
(assert (not (= var3877 null-var3698)))
(declare-const var2775 var72) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2775 null-var72)))
(assert true)
(define-const var2663 var3338 (getURLBackupAddress/-1639040226 var3877 var2775)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager: java.util.List getURLBackupAddress(org.apache.dubbo.common.URL)>(r1) 
(assert true)
(define-const var1565 var1435 (fetchAndUpdateZookeeperClientCache/54942657 var3877 var2663)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager: org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient fetchAndUpdateZookeeperClientCache(java.util.List)>(r2) 
 ; Statement: if $r3 == null goto $r4 = r0.<org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager: java.util.Map zookeeperClientMap> 
(assert (not (= var1565 null-var1435))) ; Negate: Cond: $r3 == null  
(define-const var1853 Bool (var1435_isConnected/933606471 var1565)) ; Statement: $z1 = interfaceinvoke $r3.<org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient: boolean isConnected()>() 
 ; Statement: if $z1 == 0 goto $r4 = r0.<org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager: java.util.Map zookeeperClientMap> 
(assert (not (= (ite var1853 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var1589 var3232 var3698-logger) ; Statement: $r18 = <org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var575 String String-init) ; Statement: $r17 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var575)) ; Statement: specialinvoke $r17.<java.lang.StringBuilder: void <init>()>() 
(declare-const var575!1 String)
(assert (= var575!1 ""))
(assert true)
(define-const var3406 String (append/672562846 var575!1 "find valid zookeeper client from the cache for address: ")) ; Statement: $r19 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("find valid zookeeper client from the cache for address: ") 
(declare-const var575!2 String)
(assert (= var575!2 (str.++ var575!1 "find valid zookeeper client from the cache for address: ")))
(assert true)
(define-const var943 String (append/-1031950772 var3406 (cast-from-var72-to-var3005 var2775))) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var3406!1 String)
(assert (str.prefixof var3406 var3406!1))
(assert true)
(define-const var470 String (toString/-2075883882 var943)) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2736_info/484404803 (cast-from-var3232-to-var2736 var1589) var470)) ; Statement: interfaceinvoke $r18.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r21) 

(declare-const var1589!1 var3232)
(declare-const var470!1 String)
 ; Statement: return $r3 
(check-sat)
; {getURLBackupAddress/-1639040226=([org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager, org.apache.dubbo.common.URL], java.util.List), fetchAndUpdateZookeeperClientCache/54942657=([org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager, java.util.List], org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient), var1435_isConnected/933606471=([org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var72-to-var3005=([org.apache.dubbo.common.URL], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2736_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var3232-to-var2736=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger)}
; {var3698=org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager, var3877=r0, var72=org.apache.dubbo.common.URL, var2775=r1, var3338=java.util.List, var2663=r2, var1435=org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient, var1565=$r3, var1853=$z1, var3232=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1589=$r18, var575=$r17, var3406=$r19, var3005=java.lang.Object, var943=$r20, var470=$r21, var2736=org.apache.dubbo.common.logger.Logger}
; {org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager=var3698, r0=var3877, org.apache.dubbo.common.URL=var72, r1=var2775, java.util.List=var3338, r2=var2663, org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient=var1435, $r3=var1565, $z1=var1853, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3232, $r18=var1589, $r17=var575, $r19=var3406, java.lang.Object=var3005, $r20=var943, $r21=var470, org.apache.dubbo.common.logger.Logger=var2736}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager;	r1 := @parameter0: org.apache.dubbo.common.URL;	r2 = virtualinvoke r0.<org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager: java.util.List getURLBackupAddress(org.apache.dubbo.common.URL)>(r1);	$r3 = virtualinvoke r0.<org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager: org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient fetchAndUpdateZookeeperClientCache(java.util.List)>(r2);	if $r3 == null goto $r4 = r0.<org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager: java.util.Map zookeeperClientMap>;	$z1 = interfaceinvoke $r3.<org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClient: boolean isConnected()>();	if $z1 == 0 goto $r4 = r0.<org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager: java.util.Map zookeeperClientMap>;	$r18 = <org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r17 = new java.lang.StringBuilder;	specialinvoke $r17.<java.lang.StringBuilder: void <init>()>();	$r19 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("find valid zookeeper client from the cache for address: ");	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r18.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r21);	return $r3
;block_num 3
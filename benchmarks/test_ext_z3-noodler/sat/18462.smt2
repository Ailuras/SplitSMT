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

(declare-sort var2240 0)
(declare-sort var3704 0)
(declare-sort var1617 0)
(declare-sort var660 0)
(declare-sort var253 0)
(declare-sort var248 0)
(declare-sort var1476 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var253_warn/1431914100 (var253 String String String String) void)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun lastSessionId/-1047431451 (var2240) Int)
(declare-fun Int_toHexString/1737585169 (Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun this$0/-1047431451 (var2240) var248)
(declare-fun stateChanged/-838507524 (var1476 Int) void)
(declare-fun cast-from-var248-to-var1476 (var248) var1476)
(declare-const null-var2240 var2240)
(declare-const null-var3704 var3704)
(declare-const null-var1617 var1617)
(declare-const null-var660 var660)
(declare-const var248-logger var253)
(declare-const var1617-LOST var1617)
(declare-const var11 var2240) ; Statement: r8 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient$CuratorConnectionStateListener 
(assert (not (= var11 null-var2240)))
(declare-const var1475 var3704) ; Statement: r0 := @parameter0: org.apache.curator.framework.CuratorFramework 
(assert (not (= var1475 null-var3704)))
(declare-const var1229 var1617) ; Statement: r3 := @parameter1: org.apache.curator.framework.state.ConnectionState 
(assert (not (= var1229 null-var1617)))
(define-const var2873 Int -1) ; Statement: l7 = -1L 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2244 var660) ; Statement: $r52 := @caughtexception 
(assert (not (= var2244 null-var660)))
(define-const var3135 var253 var248-logger) ; Statement: $r53 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var253_warn/1431914100 var3135 "1-35" "" "" "Curator client state changed, but failed to get the related zk session instance.")) ; Statement: interfaceinvoke $r53.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("1-35", "", "", "Curator client state changed, but failed to get the related zk session instance.") 

(declare-const var3135!1 var253)
(declare-const var188 String)
(declare-const var2552 String)
(declare-const var2552!1 String)
(declare-const var410 String)
(assert true) ; Non Conditional
(define-const var1450 var1617 var1617-LOST) ; Statement: $r4 = <org.apache.curator.framework.state.ConnectionState: org.apache.curator.framework.state.ConnectionState LOST> 
 ; Statement: if r3 != $r4 goto $r5 = <org.apache.curator.framework.state.ConnectionState: org.apache.curator.framework.state.ConnectionState SUSPENDED> 
(assert (not (not (= var1229 var1450)))) ; Negate: Cond: r3 != $r4  
(define-const var2286 var253 var248-logger) ; Statement: $r45 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1436 String String-init) ; Statement: $r44 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1436)) ; Statement: specialinvoke $r44.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1436!1 String)
(assert (= var1436!1 ""))
(assert true)
(define-const var3740 String (append/672562846 var1436!1 "Curator zookeeper session ")) ; Statement: $r47 = virtualinvoke $r44.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Curator zookeeper session ") 
(declare-const var1436!2 String)
(assert (= var1436!2 (str.++ var1436!1 "Curator zookeeper session ")))
(define-const var14 Int (lastSessionId/-1047431451 var11)) ; Statement: $l6 = r8.<org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient$CuratorConnectionStateListener: long lastSessionId> 
(define-const var1606 String (Int_toHexString/1737585169 var14)) ; Statement: $r46 = staticinvoke <java.lang.Long: java.lang.String toHexString(long)>($l6) 
(assert true)
(define-const var865 String (append/672562846 var3740 var1606)) ; Statement: $r48 = virtualinvoke $r47.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r46) 
(declare-const var3740!1 String)
(assert (= var3740!1 (str.++ var3740 var1606)))
(assert true)
(define-const var2054 String (append/672562846 var865 " expired.")) ; Statement: $r49 = virtualinvoke $r48.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" expired.") 
(declare-const var865!1 String)
(assert (= var865!1 (str.++ var865 " expired.")))
(assert true)
(define-const var1287 String (toString/-2075883882 var2054)) ; Statement: $r50 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var253_warn/1431914100 var2286 "1-35" "" "" var1287)) ; Statement: interfaceinvoke $r45.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("1-35", "", "", $r50) 

(declare-const var2286!1 var253)
(declare-const var188!1 String)
(declare-const var2552!2 String)
(declare-const var2552!3 String)
(declare-const var1287!1 String)
(define-const var3104 var248 (this$0/-1047431451 var11)) ; Statement: $r51 = r8.<org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient$CuratorConnectionStateListener: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient this$0> 
(assert true)
;(assert (stateChanged/-838507524 (cast-from-var248-to-var1476 var3104) 0)) ; Statement: virtualinvoke $r51.<org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: void stateChanged(int)>(0) 

(declare-const var3104!1 var248)
(declare-const var2314 Int)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {var253_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), lastSessionId/-1047431451=([org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient$CuratorConnectionStateListener], long), Int_toHexString/1737585169=([long], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), this$0/-1047431451=([org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient$CuratorConnectionStateListener], org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient), stateChanged/-838507524=([org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient, int], void), cast-from-var248-to-var1476=([org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient], org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient)}
; {var2240=org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient$CuratorConnectionStateListener, var11=r8, var3704=org.apache.curator.framework.CuratorFramework, var1475=r0, var1617=org.apache.curator.framework.state.ConnectionState, var1229=r3, var2873=l7, var660=java.lang.Exception, var2244=$r52, var253=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var248=org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient, var3135=$r53, var188="1-35", var2552="", var410="Curator client state changed, but failed to get the related zk session instance.", var1450=$r4, var2286=$r45, var1436=$r44, var3740=$r47, var14=$l6, var1606=$r46, var865=$r48, var2054=$r49, var1287=$r50, var3104=$r51, var1476=org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient, var2314=0}
; {org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient$CuratorConnectionStateListener=var2240, r8=var11, org.apache.curator.framework.CuratorFramework=var3704, r0=var1475, org.apache.curator.framework.state.ConnectionState=var1617, r3=var1229, l7=var2873, java.lang.Exception=var660, $r52=var2244, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var253, org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient=var248, $r53=var3135, "1-35"=var188, ""=var2552, "Curator client state changed, but failed to get the related zk session instance."=var410, $r4=var1450, $r45=var2286, $r44=var1436, $r47=var3740, $l6=var14, $r46=var1606, $r48=var865, $r49=var2054, $r50=var1287, $r51=var3104, org.apache.dubbo.remoting.zookeeper.curator5.AbstractZookeeperClient=var1476, 0=var2314}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r8 := @this: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient$CuratorConnectionStateListener;	r0 := @parameter0: org.apache.curator.framework.CuratorFramework;	r3 := @parameter1: org.apache.curator.framework.state.ConnectionState;	l7 = -1L;	$r52 := @caughtexception;	$r53 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r53.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("1-35", "", "", "Curator client state changed, but failed to get the related zk session instance.");	$r4 = <org.apache.curator.framework.state.ConnectionState: org.apache.curator.framework.state.ConnectionState LOST>;	if r3 != $r4 goto $r5 = <org.apache.curator.framework.state.ConnectionState: org.apache.curator.framework.state.ConnectionState SUSPENDED>;	$r45 = <org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r44 = new java.lang.StringBuilder;	specialinvoke $r44.<java.lang.StringBuilder: void <init>()>();	$r47 = virtualinvoke $r44.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Curator zookeeper session ");	$l6 = r8.<org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient$CuratorConnectionStateListener: long lastSessionId>;	$r46 = staticinvoke <java.lang.Long: java.lang.String toHexString(long)>($l6);	$r48 = virtualinvoke $r47.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r46);	$r49 = virtualinvoke $r48.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" expired.");	$r50 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r45.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("1-35", "", "", $r50);	$r51 = r8.<org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient$CuratorConnectionStateListener: org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient this$0>;	virtualinvoke $r51.<org.apache.dubbo.remoting.zookeeper.curator5.Curator5ZookeeperClient: void stateChanged(int)>(0);	goto [?= return];	return
;block_num 5
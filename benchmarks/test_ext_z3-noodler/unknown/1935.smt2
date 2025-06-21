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

(declare-sort var1867 0)
(declare-sort var772 0)
(declare-sort var2867 0)
(declare-sort var670 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun directory/-1669255881 (var1867) var772)
(declare-fun append/-1031950772 (String var2867) String)
(declare-fun cast-from-var772-to-var2867 (var772) var2867)
(declare-fun isExported/-1669255881 (var1867) var670)
(declare-fun cast-from-var670-to-var2867 (var670) var2867)
(declare-fun peerFlag/-1669255881 (var1867) Bool)
(declare-fun append/-388390247 (String Bool) String)
(declare-fun injvmFlag/-1669255881 (var1867) Bool)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1867 var1867)
(declare-const var659 var1867) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker 
(assert (not (= var659 null-var1867)))
(define-const var1731 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1731)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1731!1 String)
(assert (= var1731!1 ""))
(assert true)
(define-const var1419 String (append/672562846 var1731!1 "ScopeClusterInvoker{directory=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ScopeClusterInvoker{directory=") 
(declare-const var1731!2 String)
(assert (= var1731!2 (str.++ var1731!1 "ScopeClusterInvoker{directory=")))
(define-const var134 var772 (directory/-1669255881 var659)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker: org.apache.dubbo.rpc.cluster.Directory directory> 
(assert true)
(define-const var909 String (append/-1031950772 var1419 (cast-from-var772-to-var2867 var134))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var1419!1 String)
(assert (str.prefixof var1419 var1419!1))
(assert true)
(define-const var554 String (append/672562846 var909 ", isExported=")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", isExported=") 
(declare-const var909!1 String)
(assert (= var909!1 (str.++ var909 ", isExported=")))
(define-const var276 var670 (isExported/-1669255881 var659)) ; Statement: $r5 = r1.<org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker: java.util.concurrent.atomic.AtomicBoolean isExported> 
(assert true)
(define-const var3670 String (append/-1031950772 var554 (cast-from-var670-to-var2867 var276))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var554!1 String)
(assert (str.prefixof var554 var554!1))
(assert true)
(define-const var2213 String (append/672562846 var3670 ", peerFlag=")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", peerFlag=") 
(declare-const var3670!1 String)
(assert (= var3670!1 (str.++ var3670 ", peerFlag=")))
(define-const var3032 Bool (peerFlag/-1669255881 var659)) ; Statement: $z0 = r1.<org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker: boolean peerFlag> 
(assert true)
(define-const var3815 String (append/-388390247 var2213 var3032)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z0) 
(declare-const var2213!1 String)
(assert (str.prefixof var2213 var2213!1))
(assert true)
(define-const var2713 String (append/672562846 var3815 ", injvmFlag=")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", injvmFlag=") 
(declare-const var3815!1 String)
(assert (= var3815!1 (str.++ var3815 ", injvmFlag=")))
(define-const var797 Bool (injvmFlag/-1669255881 var659)) ; Statement: $z1 = r1.<org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker: boolean injvmFlag> 
(assert true)
(define-const var2877 String (append/-388390247 var2713 var797)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z1) 
(declare-const var2713!1 String)
(assert (str.prefixof var2713 var2713!1))
(assert true)
(define-const var1131 String (append/-1166366385 var2877 125)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var2877!1 String)
(assert (str.prefixof var2877 var2877!1))
(assert true)
(define-const var3637 String (toString/-2075883882 var1131)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r13 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), directory/-1669255881=([org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker], org.apache.dubbo.rpc.cluster.Directory), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var772-to-var2867=([org.apache.dubbo.rpc.cluster.Directory], java.lang.Object), isExported/-1669255881=([org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker], java.util.concurrent.atomic.AtomicBoolean), cast-from-var670-to-var2867=([java.util.concurrent.atomic.AtomicBoolean], java.lang.Object), peerFlag/-1669255881=([org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker], boolean), append/-388390247=([java.lang.StringBuilder, boolean], java.lang.StringBuilder), injvmFlag/-1669255881=([org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker], boolean), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1867=org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker, var659=r1, var1731=$r0, var1419=$r3, var772=org.apache.dubbo.rpc.cluster.Directory, var134=$r2, var2867=java.lang.Object, var909=$r4, var554=$r6, var670=java.util.concurrent.atomic.AtomicBoolean, var276=$r5, var3670=$r7, var2213=$r8, var3032=$z0, var3815=$r9, var2713=$r10, var797=$z1, var2877=$r11, var1131=$r12, var3637=$r13}
; {org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker=var1867, r1=var659, $r0=var1731, $r3=var1419, org.apache.dubbo.rpc.cluster.Directory=var772, $r2=var134, java.lang.Object=var2867, $r4=var909, $r6=var554, java.util.concurrent.atomic.AtomicBoolean=var670, $r5=var276, $r7=var3670, $r8=var2213, $z0=var3032, $r9=var3815, $r10=var2713, $z1=var797, $r11=var2877, $r12=var1131, $r13=var3637}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ScopeClusterInvoker{directory=");	$r2 = r1.<org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker: org.apache.dubbo.rpc.cluster.Directory directory>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", isExported=");	$r5 = r1.<org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker: java.util.concurrent.atomic.AtomicBoolean isExported>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", peerFlag=");	$z0 = r1.<org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker: boolean peerFlag>;	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z0);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", injvmFlag=");	$z1 = r1.<org.apache.dubbo.rpc.cluster.support.wrapper.ScopeClusterInvoker: boolean injvmFlag>;	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z1);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	return $r13
;block_num 1
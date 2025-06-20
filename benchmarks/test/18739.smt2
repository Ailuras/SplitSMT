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

(declare-sort var1405 0)
(declare-sort var1783 0)
(declare-sort var1910 0)
(declare-sort var693 0)
(declare-sort var2573 0)
(declare-sort var1365 0)
(declare-sort var3225 0)
(declare-sort var974 0)
(declare-sort var36 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1910-init () var1910)
(declare-fun <init>/-325640736 (var1910) void)
(declare-fun getAddress/-2093578336 (var1783) String)
(declare-fun var693_add/328494887 (var693 var2573) Bool)
(declare-fun cast-from-var1910-to-var693 (var1910) var693)
(declare-fun cast-from-String-to-var2573 (String) var2573)
(declare-fun var1365_emptyList/582664469 () var693)
(declare-fun getParameter/-1129333557 (var1783 String var693) var693)
(declare-fun var693_addAll/-525367613 (var693 var3225) Bool)
(declare-fun cast-from-var693-to-var3225 (var693) var3225)
(declare-fun getUsername/657618160 (var1783) String)
(declare-fun var36_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1405 var1405)
(declare-const null-var1783 var1783)
(declare-const null-String String)
(declare-const var709 var1405) ; Statement: r18 := @this: org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager 
(assert (not (= var709 null-var1405)))
(declare-const var3834 var1783) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3834 null-var1783)))
(define-const var2118 var1910 var1910-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var2118)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var2118!1 var1910)
(assert true)
(define-const var205 String (getAddress/-2093578336 var3834)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getAddress()>() 
;(assert (var693_add/328494887 (cast-from-var1910-to-var693 var2118!1) (cast-from-String-to-var2573 var205))) ; Statement: interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r2) 

(declare-const var2118!2 var1910)
(declare-const var205!1 String)
(define-const var3361 var693 var1365_emptyList/582664469) ; Statement: $r3 = staticinvoke <java.util.Collections: java.util.List emptyList()>() 
(assert true)
(define-const var2293 var693 (getParameter/-1129333557 var3834 "backup" var3361)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.util.List getParameter(java.lang.String,java.util.List)>("backup", $r3) 
;(assert (var693_addAll/-525367613 (cast-from-var1910-to-var693 var2118!2) (cast-from-var693-to-var3225 var2293))) ; Statement: interfaceinvoke $r0.<java.util.List: boolean addAll(java.util.Collection)>($r4) 

(declare-const var2118!3 var1910)
(declare-const var2293!1 var693)
(define-const var1442 String null-String) ; Statement: r19 = null 
(assert true)
(define-const var3824 String (getUsername/657618160 var3834)) ; Statement: $r5 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getUsername()>() 
(define-const var3195 Bool (var36_isNotEmpty/-1251449450 var3824)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r5) 
 ; Statement: if $z0 == 0 goto $z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r19) 
(assert (= (ite var3195 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2870 Bool (var36_isNotEmpty/-1251449450 var1442)) ; Statement: $z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r19) 
 ; Statement: if $z3 == 0 goto return $r0 
(assert (= (ite var2870 1 0) 0)) ; Cond: $z3 == 0 
 ; Statement: return $r0 
(check-sat)
; {var1910-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), getAddress/-2093578336=([org.apache.dubbo.common.URL], java.lang.String), var693_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var1910-to-var693=([java.util.ArrayList], java.util.List), cast-from-String-to-var2573=([java.lang.String], java.lang.Object), var1365_emptyList/582664469=([], java.util.List), getParameter/-1129333557=([org.apache.dubbo.common.URL, java.lang.String, java.util.List], java.util.List), var693_addAll/-525367613=([java.util.List, java.util.Collection], boolean), cast-from-var693-to-var3225=([java.util.List], java.util.Collection), getUsername/657618160=([org.apache.dubbo.common.URL], java.lang.String), var36_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1405=org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager, var709=r18, var1783=org.apache.dubbo.common.URL, var3834=r1, var1910=java.util.ArrayList, var2118=$r0, var205=$r2, var693=java.util.List, var2573=java.lang.Object, var1365=java.util.Collections, var3361=$r3, var2293=$r4, var3225=java.util.Collection, var974=null_type, var1442=r19, var3824=$r5, var36=org.apache.dubbo.common.utils.StringUtils, var3195=$z0, var2870=$z3}
; {org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager=var1405, r18=var709, org.apache.dubbo.common.URL=var1783, r1=var3834, java.util.ArrayList=var1910, $r0=var2118, $r2=var205, java.util.List=var693, java.lang.Object=var2573, java.util.Collections=var1365, $r3=var3361, $r4=var2293, java.util.Collection=var3225, null_type=var974, r19=var1442, $r5=var3824, org.apache.dubbo.common.utils.StringUtils=var36, $z0=var3195, $z3=var2870}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2}
;stmts r18 := @this: org.apache.dubbo.remoting.zookeeper.curator5.ZookeeperClientManager;	r1 := @parameter0: org.apache.dubbo.common.URL;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getAddress()>();	interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r2);	$r3 = staticinvoke <java.util.Collections: java.util.List emptyList()>();	$r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.util.List getParameter(java.lang.String,java.util.List)>("backup", $r3);	interfaceinvoke $r0.<java.util.List: boolean addAll(java.util.Collection)>($r4);	r19 = null;	$r5 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getUsername()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r5);	if $z0 == 0 goto $z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r19);	$z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r19);	if $z3 == 0 goto return $r0;	return $r0
;block_num 3
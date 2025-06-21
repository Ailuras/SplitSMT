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

(declare-sort var2659 0)
(declare-sort var1506 0)
(declare-sort var1019 0)
(declare-sort var1249 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1506-init () var1506)
(declare-fun <init>/1281898776 (var1506) void)
(declare-fun getStatedUrl/1949583675 (var2659) var1019)
(declare-fun var1019_iterator/-912451715 (var1019) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun arr-String-init () (Array Int String))
(declare-fun var1019_toArray/-775711681 (var1019 (Array Int var1249)) (Array Int var1249))
(declare-fun cast-from-var1506-to-var1019 (var1506) var1019)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var1249__ ((Array Int String)) (Array Int var1249))
(declare-fun cast-from-__Array__Int__var1249__-to-__Array__Int__String__ ((Array Int var1249)) (Array Int String))
(declare-fun String_join/-1520935655 (String (Array Int String)) String)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var2659 var2659)
(declare-const var560 var2659) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.model.ProviderModel 
(assert (not (= var560 null-var2659)))
(define-const var2075 var1506 var1506-init) ; Statement: $r0 = new java.util.LinkedList 
(assert true)
;(assert (<init>/1281898776 var2075)) ; Statement: specialinvoke $r0.<java.util.LinkedList: void <init>()>() 

(declare-const var2075!1 var1506)
(assert true)
(define-const var2021 var1019 (getStatedUrl/1949583675 var560)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ProviderModel: java.util.List getStatedUrl()>() 
(define-const var613 Iterator (var1019_iterator/-912451715 var2021)) ; Statement: r3 = interfaceinvoke $r2.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var3039 Bool (Iterator_hasNext/-1669924200 var613)) ; Statement: $z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $r4 = newarray (java.lang.String)[0] 
(assert (= (ite var3039 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3750 (Array Int String) arr-String-init) ; Statement: $r4 = newarray (java.lang.String)[0] 
(define-const var2221 (Array Int var1249) (var1019_toArray/-775711681 (cast-from-var1506-to-var1019 var2075!1) (cast-from-__Array__Int__String__-to-__Array__Int__var1249__ var3750))) ; Statement: $r5 = interfaceinvoke $r0.<java.util.List: java.lang.Object[] toArray(java.lang.Object[])>($r4) 
(define-const var2583 (Array Int String) (cast-from-__Array__Int__var1249__-to-__Array__Int__String__ var2221)) ; Statement: $r6 = (java.lang.CharSequence[]) $r5 
(define-const var334 String (String_join/-1520935655 (cast-from-String-to-String "/") var2583)) ; Statement: $r7 = staticinvoke <java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.CharSequence[])>("/", $r6) 
 ; Statement: return $r7 
(check-sat)
; {var1506-init=([], java.util.LinkedList), <init>/1281898776=([java.util.LinkedList], void), getStatedUrl/1949583675=([org.apache.dubbo.rpc.model.ProviderModel], java.util.List), var1019_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), arr-String-init=([], java.lang.String[]), var1019_toArray/-775711681=([java.util.List, java.lang.Object[]], java.lang.Object[]), cast-from-var1506-to-var1019=([java.util.LinkedList], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var1249__=([java.lang.String[]], java.lang.Object[]), cast-from-__Array__Int__var1249__-to-__Array__Int__String__=([java.lang.Object[]], java.lang.CharSequence[]), String_join/-1520935655=([java.lang.CharSequence, java.lang.CharSequence[]], java.lang.String), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var2659=org.apache.dubbo.rpc.model.ProviderModel, var560=r1, var1506=java.util.LinkedList, var2075=$r0, var1019=java.util.List, var2021=$r2, var613=r3, var3039=$z0, var3750=$r4, var1249=java.lang.Object, var2221=$r5, var2583=$r6, var334=$r7}
; {org.apache.dubbo.rpc.model.ProviderModel=var2659, r1=var560, java.util.LinkedList=var1506, $r0=var2075, java.util.List=var1019, $r2=var2021, r3=var613, $z0=var3039, $r4=var3750, java.lang.Object=var1249, $r5=var2221, $r6=var2583, $r7=var334}
;seq <java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.CharSequence[])>
;cnt {"<java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.CharSequence[])>": 1}
;stmts r1 := @parameter0: org.apache.dubbo.rpc.model.ProviderModel;	$r0 = new java.util.LinkedList;	specialinvoke $r0.<java.util.LinkedList: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ProviderModel: java.util.List getStatedUrl()>();	r3 = interfaceinvoke $r2.<java.util.List: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r3.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $r4 = newarray (java.lang.String)[0];	$r4 = newarray (java.lang.String)[0];	$r5 = interfaceinvoke $r0.<java.util.List: java.lang.Object[] toArray(java.lang.Object[])>($r4);	$r6 = (java.lang.CharSequence[]) $r5;	$r7 = staticinvoke <java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.CharSequence[])>("/", $r6);	return $r7
;block_num 3
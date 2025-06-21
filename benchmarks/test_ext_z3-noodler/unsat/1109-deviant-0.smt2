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

(declare-sort var3664 0)
(declare-sort var2613 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1209756239 ((s String) (subs String)) Int (str.indexof s subs 0))
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3664 var3664)
(declare-const null-String String)
(declare-const var3407 var3664) ; Statement: r7 := @this: org.apache.dubbo.rpc.cluster.support.MergeableClusterInvoker 
(assert (not (= var3407 null-var3664)))
(declare-const var1389 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1389 null-String)))
(assert true)
(define-const var1472 Int (indexOf/-1209756239 var1389 "/")) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>("/") 
 ; Statement: if i0 <= 0 goto return r0 
(assert (not (<= var1472 0))) ; Negate: Cond: i0 <= 0  
(define-const var2100 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2100)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2100!1 String)
(assert (= var2100!1 ""))
(assert true)
(define-const var1260 String (append/672562846 var2100!1 "group [ ")) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("group [ ") 
(declare-const var2100!2 String)
(assert (= var2100!2 (str.++ var2100!1 "group [ ")))
(assert (not (and true (and (>= 0 0) (>= (str.len var1389) var1472) (>= var1472 0)))))
(check-sat)
; {indexOf/-1209756239=([java.lang.String, java.lang.String], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), substring/-1240304868=([java.lang.String, int, int], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3664=org.apache.dubbo.rpc.cluster.support.MergeableClusterInvoker, var3407=r7, var1389=r0, var2613=null_type, var1472=i0, var2100=$r1, var1260=$r3, var3659=$r2, var3328=$r4, var2212=$r5, var1501=$r6}
; {org.apache.dubbo.rpc.cluster.support.MergeableClusterInvoker=var3664, r7=var3407, r0=var1389, null_type=var2613, i0=var1472, $r1=var2100, $r3=var1260, $r2=var3659, $r4=var3328, $r5=var2212, $r6=var1501}
;seq <java.lang.String: int indexOf(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int indexOf(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r7 := @this: org.apache.dubbo.rpc.cluster.support.MergeableClusterInvoker;	r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>("/");	if i0 <= 0 goto return r0;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("group [ ");	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(0, i0);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ]");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 2
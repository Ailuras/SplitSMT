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

(declare-sort var3020 0)
(declare-sort var2039 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun description/195094363 (var3020) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun withDescription/65961942 (var3020 String) var3020)
(declare-const null-var3020 var3020)
(declare-const null-String String)
(declare-const var2985 var3020) ; Statement: r0 := @this: org.apache.dubbo.rpc.TriRpcStatus 
(assert (not (= var2985 null-var3020)))
(declare-const var3313 String) ; Statement: r5 := @parameter0: java.lang.String 
(assert (not (= var3313 null-String)))
(define-const var2257 String (description/195094363 var2985)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.TriRpcStatus: java.lang.String description> 
 ; Statement: if $r1 != null goto $r2 = new java.lang.StringBuilder 
(assert (not (= var2257 null-String))) ; Cond: $r1 != null 
(define-const var1642 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1642)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1642!1 String)
(assert (= var1642!1 ""))
(define-const var139 String (description/195094363 var2985)) ; Statement: $r3 = r0.<org.apache.dubbo.rpc.TriRpcStatus: java.lang.String description> 
(assert true)
(define-const var1197 String (append/672562846 var1642!1 var139)) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1642!2 String)
(assert (= var1642!2 (str.++ var1642!1 var139)))
(assert true)
(define-const var346 String (append/672562846 var1197 "\n")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(declare-const var1197!1 String)
(assert (= var1197!1 (str.++ var1197 "\n")))
(assert true)
(define-const var1645 String (append/672562846 var346 var3313)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5) 
(declare-const var346!1 String)
(assert (= var346!1 (str.++ var346 var3313)))
(assert true)
(define-const var1686 String (toString/-2075883882 var1645)) ; Statement: r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
(define-const var1567 var3020 (withDescription/65961942 var2985 var1686)) ; Statement: $r9 = virtualinvoke r0.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus withDescription(java.lang.String)>(r8) 
 ; Statement: return $r9 
(check-sat)
; {description/195094363=([org.apache.dubbo.rpc.TriRpcStatus], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), withDescription/65961942=([org.apache.dubbo.rpc.TriRpcStatus, java.lang.String], org.apache.dubbo.rpc.TriRpcStatus)}
; {var3020=org.apache.dubbo.rpc.TriRpcStatus, var2985=r0, var3313=r5, var2039=null_type, var2257=$r1, var1642=$r2, var139=$r3, var1197=$r4, var346=$r6, var1645=$r7, var1686=r8, var1567=$r9}
; {org.apache.dubbo.rpc.TriRpcStatus=var3020, r0=var2985, r5=var3313, null_type=var2039, $r1=var2257, $r2=var1642, $r3=var139, $r4=var1197, $r6=var346, $r7=var1645, r8=var1686, $r9=var1567}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.TriRpcStatus;	r5 := @parameter0: java.lang.String;	$r1 = r0.<org.apache.dubbo.rpc.TriRpcStatus: java.lang.String description>;	if $r1 != null goto $r2 = new java.lang.StringBuilder;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = r0.<org.apache.dubbo.rpc.TriRpcStatus: java.lang.String description>;	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5);	r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	$r9 = virtualinvoke r0.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus withDescription(java.lang.String)>(r8);	return $r9
;block_num 2
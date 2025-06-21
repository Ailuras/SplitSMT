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

(declare-sort var1452 0)
(declare-sort var3098 0)
(declare-sort var2082 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2082_hasText/853333513 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-901862667 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1452 var1452)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2729 var1452) ; Statement: r10 := @this: org.apache.dubbo.rpc.model.ScopeModel 
(assert (not (= var2729 null-var1452)))
(declare-const var3248 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3248 null-String)))
(declare-const var2016 Int) ; Statement: l0 := @parameter1: long 
(assert (not (= var2016 null-Int)))
(define-const var1904 Bool (var2082_hasText/853333513 (cast-from-String-to-String var3248))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = new java.lang.StringBuilder 
(assert (= (ite var1904 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3372 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3372)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3372!1 String)
(assert (= var3372!1 ""))
(assert true)
(define-const var1577 String (append/672562846 var3372!1 "")) ; Statement: $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("") 
(declare-const var3372!2 String)
(assert (= var3372!2 (str.++ var3372!1 "")))
(assert true)
(define-const var296 String (append/-901862667 var1577 var2016)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>(l0) 
(declare-const var1577!1 String)
(assert (str.prefixof var1577 var1577!1))
(assert true)
(define-const var3470 String (toString/-2075883882 var296)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {var2082_hasText/853333513=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1452=org.apache.dubbo.rpc.model.ScopeModel, var2729=r10, var3248=r0, var3098=null_type, var2016=l0, var2082=org.apache.dubbo.common.utils.StringUtils, var1904=$z0, var3372=$r1, var1577=$r2, var296=$r3, var3470=$r4}
; {org.apache.dubbo.rpc.model.ScopeModel=var1452, r10=var2729, r0=var3248, null_type=var3098, l0=var2016, org.apache.dubbo.common.utils.StringUtils=var2082, $z0=var1904, $r1=var3372, $r2=var1577, $r3=var296, $r4=var3470}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r10 := @this: org.apache.dubbo.rpc.model.ScopeModel;	r0 := @parameter0: java.lang.String;	l0 := @parameter1: long;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>(r0);	if $z0 == 0 goto $r1 = new java.lang.StringBuilder;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("");	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>(l0);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 2
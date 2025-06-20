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

(declare-sort var617 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getServiceInterface/-1311863806 (var617) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun compatibleAppend/-1269882790 (var617 String String) void)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var617 var617)
(declare-const var3462 var617) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3462 null-var617)))
(define-const var1028 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1028)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1028!1 String)
(assert (= var1028!1 ""))
(assert true)
(define-const var2210 String (getServiceInterface/-1311863806 var3462)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(assert true)
;(assert (append/672562846 var1028!1 var2210)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1028!2 String)
(assert (= var1028!2 (str.++ var1028!1 var2210)))
(assert true)
;(assert (compatibleAppend/-1269882790 var3462 var1028!2 "version")) ; Statement: specialinvoke r1.<org.apache.dubbo.common.URL: void compatibleAppend(java.lang.StringBuilder,java.lang.String)>($r0, "version") 

(declare-const var3462!1 var617)
(declare-const var1028!3 String)
(declare-const var3779 String)
(assert true)
;(assert (compatibleAppend/-1269882790 var3462!1 var1028!3 "group")) ; Statement: specialinvoke r1.<org.apache.dubbo.common.URL: void compatibleAppend(java.lang.StringBuilder,java.lang.String)>($r0, "group") 

(declare-const var3462!2 var617)
(declare-const var1028!4 String)
(declare-const var3726 String)
(assert true)
(define-const var679 String (toString/-2075883882 var1028!4)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r3 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), compatibleAppend/-1269882790=([org.apache.dubbo.common.URL, java.lang.StringBuilder, java.lang.String], void), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var617=org.apache.dubbo.common.URL, var3462=r1, var1028=$r0, var2210=$r2, var3779="version", var3726="group", var679=$r3}
; {org.apache.dubbo.common.URL=var617, r1=var3462, $r0=var1028, $r2=var2210, "version"=var3779, "group"=var3726, $r3=var679}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	specialinvoke r1.<org.apache.dubbo.common.URL: void compatibleAppend(java.lang.StringBuilder,java.lang.String)>($r0, "version");	specialinvoke r1.<org.apache.dubbo.common.URL: void compatibleAppend(java.lang.StringBuilder,java.lang.String)>($r0, "group");	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r3
;block_num 1
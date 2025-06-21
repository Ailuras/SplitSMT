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

(declare-sort var3139 0)
(declare-sort var1746 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3139 var3139)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var72 var3139) ; Statement: r5 := @this: org.apache.dubbo.common.url.component.URLAddress 
(assert (not (= var72 null-var3139)))
(declare-const var1590 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1590 null-String)))
(declare-const var2165 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var2165 null-Int)))
 ; Statement: if i0 > 0 goto $r0 = new java.lang.StringBuilder 
(assert (> var2165 0)) ; Cond: i0 > 0 
(define-const var3346 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3346)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3346!1 String)
(assert (= var3346!1 ""))
(assert true)
(define-const var2461 String (append/672562846 var3346!1 var1590)) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var3346!2 String)
(assert (= var3346!2 (str.++ var3346!1 var1590)))
(assert true)
(define-const var3665 String (append/-1166366385 var2461 58)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var2461!1 String)
(assert (str.prefixof var2461 var2461!1))
(assert true)
(define-const var1333 String (append/-1001720160 var3665 var2165)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var3665!1 String)
(assert (str.prefixof var3665 var3665!1))
(assert true)
(define-const var22 String (toString/-2075883882 var1333)) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3139=org.apache.dubbo.common.url.component.URLAddress, var72=r5, var1590=r1, var1746=null_type, var2165=i0, var3346=$r0, var2461=$r2, var3665=$r3, var1333=$r4, var22=$r6}
; {org.apache.dubbo.common.url.component.URLAddress=var3139, r5=var72, r1=var1590, null_type=var1746, i0=var2165, $r0=var3346, $r2=var2461, $r3=var3665, $r4=var1333, $r6=var22}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r5 := @this: org.apache.dubbo.common.url.component.URLAddress;	r1 := @parameter0: java.lang.String;	i0 := @parameter1: int;	if i0 > 0 goto $r0 = new java.lang.StringBuilder;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 3
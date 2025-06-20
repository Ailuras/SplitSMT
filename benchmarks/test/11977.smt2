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

(declare-sort var3849 0)
(declare-sort var3658 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3849 var3849)
(declare-const null-String String)
(declare-const var2597 var3849) ; Statement: r7 := @this: org.apache.dubbo.metadata.store.nacos.NacosMetadataReport 
(assert (not (= var2597 null-var3849)))
(declare-const var1232 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1232 null-String)))
(declare-const var1787 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var1787 null-String)))
(define-const var1488 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1488)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1488!1 String)
(assert (= var1488!1 ""))
(assert true)
(define-const var672 String (append/672562846 var1488!1 var1232)) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var1488!2 String)
(assert (= var1488!2 (str.++ var1488!1 var1232)))
(assert true)
(define-const var1850 String (append/-1166366385 var672 45)) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(45) 
(declare-const var672!1 String)
(assert (str.prefixof var672 var672!1))
(assert true)
(define-const var1154 String (append/672562846 var1850 var1787)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var1850!1 String)
(assert (= var1850!1 (str.++ var1850 var1787)))
(assert true)
(define-const var3722 String (toString/-2075883882 var1154)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3849=org.apache.dubbo.metadata.store.nacos.NacosMetadataReport, var2597=r7, var1232=r1, var3658=null_type, var1787=r3, var1488=$r0, var672=$r2, var1850=$r4, var1154=$r5, var3722=$r6}
; {org.apache.dubbo.metadata.store.nacos.NacosMetadataReport=var3849, r7=var2597, r1=var1232, null_type=var3658, r3=var1787, $r0=var1488, $r2=var672, $r4=var1850, $r5=var1154, $r6=var3722}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r7 := @this: org.apache.dubbo.metadata.store.nacos.NacosMetadataReport;	r1 := @parameter0: java.lang.String;	r3 := @parameter1: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(45);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1
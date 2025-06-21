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

(declare-sort var3904 0)
(declare-sort var924 0)
(declare-sort var531 0)
(declare-sort var3484 0)
(declare-sort var966 0)
(declare-sort var3692 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var924_access$100/-1735106965 (var924) var3484)
(declare-fun ordinal/-291641772 (var966) Int)
(declare-fun cast-from-var3484-to-var966 (var3484) var966)
(declare-fun var3692_length/1485543905 (String) Int)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var3692_repeat/1008746495 (String Int) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3904 var3904)
(declare-const null-var924 var924)
(declare-const null-Int Int)
(declare-const null-String String)
(declare-const var1675 var3904) ; Statement: r20 := @this: org.apache.dubbo.qos.textui.TTable 
(assert (not (= var1675 null-var3904)))
(declare-const var681 var924) ; Statement: r0 := @parameter0: org.apache.dubbo.qos.textui.TTable$ColumnDefine 
(assert (not (= var681 null-var924)))
(declare-const var1632 Int) ; Statement: i2 := @parameter1: int 
(assert (not (= var1632 null-Int)))
(declare-const var1956 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var1956 null-String)))
(define-const var2207 var3484 (var924_access$100/-1735106965 var681)) ; Statement: $r1 = staticinvoke <org.apache.dubbo.qos.textui.TTable$ColumnDefine: org.apache.dubbo.qos.textui.TTable$Align access$100(org.apache.dubbo.qos.textui.TTable$ColumnDefine)>(r0) 
(assert true)
(define-const var3143 Int (ordinal/-291641772 (cast-from-var3484-to-var966 var2207))) ; Statement: $i0 = virtualinvoke $r1.<org.apache.dubbo.qos.textui.TTable$Align: int ordinal()>() 
 ; Statement: tableswitch($i0) {     case 0: goto $r15 = new java.lang.StringBuilder;     case 1: goto $r10 = new java.lang.StringBuilder;     case 2: goto i1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>(r2);     default: goto $r15 = new java.lang.StringBuilder; } 
(assert (and (= var3143 2) (and (not (= var3143 1)) (and (not (= var3143 0)) true)))) ; Intersect: Cond: $i0 == 2  and Intersect: Negate: Cond: $i0 == 1   and Intersect: Negate: Cond: $i0 == 0   and Non Conditional   
(define-const var35 Int (var3692_length/1485543905 (cast-from-String-to-String var1956))) ; Statement: i1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>(r2) 
(define-const var880 Int (- var1632 var35)) ; Statement: i3 = i2 - i1 
(define-const var1524 Int (div var880 2)) ; Statement: i4 = i3 / 2 
(define-const var1864 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1864)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1864!1 String)
(assert (= var1864!1 ""))
(define-const var2070 Int (- var880 var1524)) ; Statement: $i5 = i3 - i4 
(define-const var3190 String (var3692_repeat/1008746495 " " var2070)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String repeat(java.lang.String,int)>(" ", $i5) 
(assert true)
(define-const var3519 String (append/672562846 var1864!1 var3190)) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var1864!2 String)
(assert (= var1864!2 (str.++ var1864!1 var3190)))
(assert true)
(define-const var3322 String (append/672562846 var3519 "%s")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("%s") 
(declare-const var3519!1 String)
(assert (= var3519!1 (str.++ var3519 "%s")))
(define-const var1053 String (var3692_repeat/1008746495 " " var1524)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String repeat(java.lang.String,int)>(" ", i4) 
(assert true)
(define-const var900 String (append/672562846 var3322 var1053)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var3322!1 String)
(assert (= var3322!1 (str.++ var3322 var1053)))
(assert true)
(define-const var1640 String (toString/-2075883882 var900)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {var924_access$100/-1735106965=([org.apache.dubbo.qos.textui.TTable$ColumnDefine], org.apache.dubbo.qos.textui.TTable$Align), ordinal/-291641772=([java.lang.Enum], int), cast-from-var3484-to-var966=([org.apache.dubbo.qos.textui.TTable$Align], java.lang.Enum), var3692_length/1485543905=([java.lang.CharSequence], int), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var3692_repeat/1008746495=([java.lang.String, int], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3904=org.apache.dubbo.qos.textui.TTable, var1675=r20, var924=org.apache.dubbo.qos.textui.TTable$ColumnDefine, var681=r0, var1632=i2, var1956=r2, var531=null_type, var3484=org.apache.dubbo.qos.textui.TTable$Align, var2207=$r1, var966=java.lang.Enum, var3143=$i0, var3692=org.apache.dubbo.common.utils.StringUtils, var35=i1, var880=i3, var1524=i4, var1864=$r3, var2070=$i5, var3190=$r4, var3519=$r5, var3322=$r7, var1053=$r6, var900=$r8, var1640=$r9}
; {org.apache.dubbo.qos.textui.TTable=var3904, r20=var1675, org.apache.dubbo.qos.textui.TTable$ColumnDefine=var924, r0=var681, i2=var1632, r2=var1956, null_type=var531, org.apache.dubbo.qos.textui.TTable$Align=var3484, $r1=var2207, java.lang.Enum=var966, $i0=var3143, org.apache.dubbo.common.utils.StringUtils=var3692, i1=var35, i3=var880, i4=var1524, $r3=var1864, $i5=var2070, $r4=var3190, $r5=var3519, $r7=var3322, $r6=var1053, $r8=var900, $r9=var1640}
;seq <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>;	<java.lang.StringBuilder: void <init>()>;	<org.apache.dubbo.common.utils.StringUtils: java.lang.String repeat(java.lang.String,int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: java.lang.String repeat(java.lang.String,int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<org.apache.dubbo.common.utils.StringUtils: java.lang.String repeat(java.lang.String,int)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r20 := @this: org.apache.dubbo.qos.textui.TTable;	r0 := @parameter0: org.apache.dubbo.qos.textui.TTable$ColumnDefine;	i2 := @parameter1: int;	r2 := @parameter2: java.lang.String;	$r1 = staticinvoke <org.apache.dubbo.qos.textui.TTable$ColumnDefine: org.apache.dubbo.qos.textui.TTable$Align access$100(org.apache.dubbo.qos.textui.TTable$ColumnDefine)>(r0);	$i0 = virtualinvoke $r1.<org.apache.dubbo.qos.textui.TTable$Align: int ordinal()>();	tableswitch($i0) {     case 0: goto $r15 = new java.lang.StringBuilder;     case 1: goto $r10 = new java.lang.StringBuilder;     case 2: goto i1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>(r2);     default: goto $r15 = new java.lang.StringBuilder; };	i1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: int length(java.lang.CharSequence)>(r2);	i3 = i2 - i1;	i4 = i3 / 2;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$i5 = i3 - i4;	$r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String repeat(java.lang.String,int)>(" ", $i5);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("%s");	$r6 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String repeat(java.lang.String,int)>(" ", i4);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 2